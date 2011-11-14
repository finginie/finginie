$ ->
  $("a[data-slidein=true]").click ->
    $(".news .active").removeClass 'active'
    target = $(this).attr 'href'
    $(target).addClass 'active'
    $("#{target}-parent").addClass 'active'
    return false
  $(".news nav a:first").click()

  slide_show = ->
    $slide = $('.slide.active').removeClass('active').next()
    $slide = $('.slide:first') unless $slide.length
    $slide.addClass('active')
  window.setInterval slide_show, 4000
