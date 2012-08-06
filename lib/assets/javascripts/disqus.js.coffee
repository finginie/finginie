$ ->
  if(RAILS_ENV == 'production')
    $.globalEval "var disqus_shortname = 'finginie2';"
    if ($("#disqus_thread").data('disqus_identifier') != undefined)
      $.globalEval "var disqus_identifier = $('#disqus_thread').data('disqus_identifier')"
    $.getScript "http://#{disqus_shortname}.disqus.com/embed.js"
