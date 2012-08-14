$ ->
  if AirbrakeKey != ''
    $.getScript "http://#{AirbrakeHost}/javascripts/notifier.js", ->
      window.Airbrake = Airbrake
      Airbrake.setKey AirbrakeKey
      Airbrake.setEnvironment RAILS_ENV
      Airbrake.setHost AirbrakeHost
      Airbrake.setErrorDefaults
        url: window.location.href
        component: controller_name
        action: action_name
      Airbrake.setGuessFunctionName true
      Airbrake.trackJQ true
