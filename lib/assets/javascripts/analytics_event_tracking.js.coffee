if RAILS_ENV=='production'
  $ ->
    $('.ga-track-event').each ->
      $(@).click =>
        _gaq.push [
          '_trackEvent',
          $(@).data('category'),
          $(@).data('action'),
          $(@).data('label')
        ]

