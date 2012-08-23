if RAILS_ENV=='production'
  $ ->
    $('.ga-track-event').on 'click', ->
      _gaq.push [
        '_trackEvent',
        $(@).data('category'),
        $(@).data('action')
      ]
