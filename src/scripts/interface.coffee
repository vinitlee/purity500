current = parseInt(localStorage['interface_place']) or 1

savePlace = ->
  localStorage['interface_place'] = Math.floor(current)

n = mainTest.map[Math.round(current)]
render = (delta=0,sec=false) ->
  current = current or 1
  if not (current == 1 and delta <= 0) and not (current == mainTest.numQ and delta >= 0)
    if sec
      n += delta
      n = bound(n,1,mainTest.numS)
      current = mainTest.smap[Math.round(n)]
    else
      current += delta
      current = bound(current,1,mainTest.numQ)
      n = mainTest.map[Math.round(current)]
    goTo(current)
    savePlace()

goTo = (i) ->
  i = Math.round(i)
  q = mainTest.getQuestion(i)
  $('.question .number').html(q.question.num)
  $('.question .text').html(q.question.text)
  $('.section .number').html(q.section.num)
  $('.section .text').html(q.section.text)
  drawState(i)

drawState = (i) ->
  if mainAnswers.get(i)
    $('.view').addClass('done')
    antagonize()
  else
    $('.view').removeClass('done')

toggleAnswer = ->
  mainAnswers.toggle(Math.floor(current))
  drawState(Math.floor(current))
tinderAnswer = (ans) ->
  if ans
    mainAnswers.done(Math.floor(current))
  else
    mainAnswers.undone(Math.floor(current))
  drawState(Math.floor(current))
  setTimeout( ->
    render(1)
  ,200)

$('.response').click(toggleAnswer)

$('.view').bind 'wheel',(e) ->
  render(e.originalEvent.deltaY/10)
$('.statusbar').bind 'wheel',(e) ->
  render(e.originalEvent.deltaY/10,true)
goTo(current)
$(window).keydown (e) ->
  switch e.which
    when 32 then toggleAnswer()
    when 74 then render(-1)
    when 75 then render(1)
    when 72 then render(-1,true)
    when 76 then render(1,true)

    when 37 then render(-1)
    when 39 then render(1)
    when 38 then render(-1,true)
    when 40 then render(1,true)
    else
      # console.log e.which
      return
  e.originalEvent.preventDefault()
$('body').on 'swiperight',() -> render(1)
$('body').on 'swipeleft',() -> render(-1)
$('body').on 'tap',() -> console.log "Tapped"

hammertime = new Hammer($('body')[0])
hammertime.on 'pandown', (e) -> render(-1/5)
hammertime.on 'panup', (e) -> render(1/5)
hammertime.on 'swipedown', (e) -> render(-1)
hammertime.on 'swipeup', (e) -> render(1)
hammertime.on 'swiperight', (e) -> tinderAnswer(true)
hammertime.on 'swipeleft', (e) -> tinderAnswer(false)
hammertime.on 'tap', (e) -> toggleAnswer()