$ ->
  $.globalEval "var disqus_shortname = 'finginie2';"
  $.globalEval "var disqus_identifier = $('#disqus_thread').data('disqus_identifier')"
  $.getScript "http://#{disqus_shortname}.disqus.com/embed.js"
