$ ->
  $("#twittershare").click ->
    window.location = "#{$(@).data().postUrl}&twitter_message=#{$('#twitter_message').val()}"