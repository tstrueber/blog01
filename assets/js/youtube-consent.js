(function () {
  function loadYouTubeVideo(container) {
    var videoId = container.getAttribute('data-youtube-id');
    var title = container.getAttribute('data-youtube-title') || 'YouTube-Video';

    if (!videoId) {
      return;
    }

    var iframe = document.createElement('iframe');
    iframe.src = 'https://www.youtube-nocookie.com/embed/' + encodeURIComponent(videoId) + '?autoplay=1';
    iframe.title = title;
    iframe.loading = 'lazy';
    iframe.referrerPolicy = 'strict-origin-when-cross-origin';
    iframe.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';
    iframe.allowFullscreen = true;

    container.textContent = '';
    container.classList.add('youtube-consent--loaded');
    container.appendChild(iframe);
  }

  document.addEventListener('click', function (event) {
    var button = event.target.closest('[data-youtube-load]');

    if (!button) {
      return;
    }

    var container = button.closest('.youtube-consent');
    loadYouTubeVideo(container);
  });
})();
