class Answers
  constructor: (test,answers={}) ->
    @answers = answers
    @test = test
    @numAn = 0
    for i,s of @test.map
      @numAn++
      @answers[i] = @answers[i] or false
    @recover()
    @score()
  score: ->
    s = 0
    for i,a of @answers
      if a
        s++
    s = (@numAn - s) / @numAn
    console.log s
    $('.score .calculated').html(Math.round(s*100*100)/100)
  answer: (i,b) ->
    @answers[i] = b
    @store()
    @score()
  done: (i) ->
    @answer(i,true)
  undone: (i) ->
    @answer(i,false)
  toggle: (i) ->
    @answer(i,not @get(i))
  get: (i) ->
    @answers[i]
  store: ->
    list = []
    for i,b of @answers
      list[i-1] = if b then 1 else 0
    localStorage['answers_list'] = list
  recover: ->
    l = localStorage['answers_list'].split(',')
    for a,i in l
      @answers[i+1] = (a == '1')
  clear: (all) ->
    for i,s of @test.map
      @answers[i] = false
    if all
      for j,d of localStorage
        if j.search('answer') >= 0
          localStorage[j] = null

@mainAnswers = new Answers(mainTest)