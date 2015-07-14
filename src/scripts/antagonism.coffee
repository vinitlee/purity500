antagonism = [
  "Disgusting.",
  "What a slut.",
  "You're ruining the establishment of marriage.",
  "Look at yourself.",
  "You are fatter than you think.",
  "This test doesn't actually end.",
  "None of your friends like you.",
  "Little bitch."
]

@antagonize = ->
  $('.antagonism').html(antagonism[Math.floor(Math.random()*antagonism.length)])