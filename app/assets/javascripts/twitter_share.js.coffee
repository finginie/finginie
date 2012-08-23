$ ->
  $("#twittershare").click ->
    window.location = "#{$(@).data().post_url}&twitter_message=#{$('#twitter_message').val()}"