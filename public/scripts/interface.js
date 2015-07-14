(function() {
  var current, drawState, goTo, hammertime, n, render, savePlace, tinderAnswer, toggleAnswer;

  current = parseInt(localStorage['interface_place']) || 1;

  savePlace = function() {
    return localStorage['interface_place'] = Math.floor(current);
  };

  n = mainTest.map[Math.round(current)];

  render = function(delta, sec) {
    if (delta == null) {
      delta = 0;
    }
    if (sec == null) {
      sec = false;
    }
    current = current || 1;
    if (!(current === 1 && delta <= 0) && !(current === mainTest.numQ && delta >= 0)) {
      if (sec) {
        n += delta;
        n = bound(n, 1, mainTest.numS);
        current = mainTest.smap[Math.round(n)];
      } else {
        current += delta;
        current = bound(current, 1, mainTest.numQ);
        n = mainTest.map[Math.round(current)];
      }
      goTo(current);
      return savePlace();
    }
  };

  goTo = function(i) {
    var q;
    i = Math.round(i);
    q = mainTest.getQuestion(i);
    $('.question .number').html(q.question.num);
    $('.question .text').html(q.question.text);
    $('.section .number').html(q.section.num);
    $('.section .text').html(q.section.text);
    return drawState(i);
  };

  drawState = function(i) {
    if (mainAnswers.get(i)) {
      $('.view').addClass('done');
      return antagonize();
    } else {
      return $('.view').removeClass('done');
    }
  };

  toggleAnswer = function() {
    mainAnswers.toggle(Math.floor(current));
    return drawState(Math.floor(current));
  };

  tinderAnswer = function(ans) {
    if (ans) {
      mainAnswers.done(Math.floor(current));
    } else {
      mainAnswers.undone(Math.floor(current));
    }
    drawState(Math.floor(current));
    return setTimeout(function() {
      return render(1);
    }, 200);
  };

  $('.response').click(toggleAnswer);

  $('.view').bind('wheel', function(e) {
    return render(e.originalEvent.deltaY / 10);
  });

  $('.statusbar').bind('wheel', function(e) {
    return render(e.originalEvent.deltaY / 10, true);
  });

  goTo(current);

  $(window).keydown(function(e) {
    switch (e.which) {
      case 32:
        toggleAnswer();
        break;
      case 74:
        render(-1);
        break;
      case 75:
        render(1);
        break;
      case 72:
        render(-1, true);
        break;
      case 76:
        render(1, true);
        break;
      case 37:
        render(-1);
        break;
      case 39:
        render(1);
        break;
      case 38:
        render(-1, true);
        break;
      case 40:
        render(1, true);
        break;
      default:
        return;
    }
    return e.originalEvent.preventDefault();
  });

  $('body').on('swiperight', function() {
    return render(1);
  });

  $('body').on('swipeleft', function() {
    return render(-1);
  });

  $('body').on('tap', function() {
    return console.log("Tapped");
  });

  hammertime = new Hammer($('body')[0]);

  hammertime.on('pandown', function(e) {
    return render(-1 / 5);
  });

  hammertime.on('panup', function(e) {
    return render(1 / 5);
  });

  hammertime.on('swipedown', function(e) {
    return render(-1);
  });

  hammertime.on('swipeup', function(e) {
    return render(1);
  });

  hammertime.on('swiperight', function(e) {
    return tinderAnswer(true);
  });

  hammertime.on('swipeleft', function(e) {
    return tinderAnswer(false);
  });

  hammertime.on('tap', function(e) {
    return toggleAnswer();
  });

}).call(this);
