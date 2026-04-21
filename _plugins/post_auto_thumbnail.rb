require 'cgi'

module PostAutoThumbnail
  module_function

  MARKDOWN_IMAGE_REGEX = %r{!\[(?<alt>[^\]]*)\]\((?<src>[^)\s]+)}i.freeze
  HTML_IMAGE_REGEX = %r{<img[^>]+src=["'](?<src>[^"']+)["'][^>]*>}i.freeze
  HTML_ALT_REGEX = %r{alt=["'](?<alt>[^"']*)["']}i.freeze

  def assign_thumbnail(post)
    return unless post.is_a?(Jekyll::Document) && post.collection.label == 'posts'
    return if post.data['image']

    extracted = extract_first_image(post.content)
    post.data['image'] = extracted || placeholder_image(post)
  end

  def extract_first_image(content)
    return if content.to_s.empty?

    markdown_match = content.match(MARKDOWN_IMAGE_REGEX)
    return build_image_hash(markdown_match[:src], markdown_match[:alt]) if markdown_match

    html_match = content.match(HTML_IMAGE_REGEX)
    return unless html_match

    alt = html_match[0][HTML_ALT_REGEX, :alt]
    build_image_hash(html_match[:src], alt)
  end

  def build_image_hash(src, alt)
    return if src.to_s.empty?

    {
      'path' => src,
      'alt' => alt.to_s.strip.empty? ? 'Artikelbild' : alt.to_s.strip
    }
  end

  def placeholder_image(post)
    {
      'path' => placeholder_svg(post),
      'alt' => post.data['title'].to_s
    }
  end

  def placeholder_svg(post)
    title = CGI.escapeHTML(post.data['title'].to_s)
    category = CGI.escapeHTML(Array(post.data['categories']).first.to_s)
    date = post.date.strftime('%d.%m.%Y')

    svg = <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 630" role="img" aria-label="#{title}">
        <defs>
          <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="#153047" />
            <stop offset="55%" stop-color="#255d72" />
            <stop offset="100%" stop-color="#f2a65a" />
          </linearGradient>
        </defs>
        <rect width="1200" height="630" fill="url(#bg)" rx="36" />
        <circle cx="1020" cy="112" r="164" fill="rgba(255,255,255,0.08)" />
        <circle cx="138" cy="542" r="196" fill="rgba(255,255,255,0.08)" />
        <rect x="82" y="78" width="220" height="44" rx="22" fill="rgba(255,255,255,0.16)" />
        <text x="110" y="108" fill="#fdf8f3" font-family="Arial, sans-serif" font-size="24" font-weight="700">Modern Workplace Diaries</text>
        <text x="82" y="214" fill="#ffffff" font-family="Arial, sans-serif" font-size="66" font-weight="700">#{title}</text>
        <text x="82" y="520" fill="#f6efe8" font-family="Arial, sans-serif" font-size="26" font-weight="600">#{category}</text>
        <text x="82" y="560" fill="#f6efe8" font-family="Arial, sans-serif" font-size="24">#{date}</text>
      </svg>
    SVG

    "data:image/svg+xml,#{CGI.escape(svg).gsub('+', '%20')}"
  end
end

Jekyll::Hooks.register :documents, :pre_render do |document|
  PostAutoThumbnail.assign_thumbnail(document)
end
