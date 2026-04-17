module Blog01
  class TagPage < Jekyll::PageWithoutAFile
    def initialize(site, base, dir, tag_name, posts)
      super(site, base, dir, "index.html")

      data["title"] = tag_name
      data["posts"] = posts.sort_by { |post| -post.date.to_f }
      data["layout"] = "tag"
      data["permalink"] = "/#{dir}/"
      self.content = ""
    end
  end

  class TagPagesGenerator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      site.tags.each do |tag_name, posts|
        slug = Jekyll::Utils.slugify(tag_name, mode: "pretty", cased: false)
        dir = File.join("tags", slug)
        site.pages << TagPage.new(site, site.source, dir, tag_name, posts)
      end
    end
  end
end
