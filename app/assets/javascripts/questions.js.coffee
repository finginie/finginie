# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#answerBtn").click ->
    unless $("input:radio[name=question[choices]]:checked").val()
      alert "Plaese select any answer"
      false
    true
