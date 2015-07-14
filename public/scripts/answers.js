(function() {
  var Answers;

  Answers = (function() {
    function Answers(test, answers) {
      var i, ref, s;
      if (answers == null) {
        answers = {};
      }
      this.answers = answers;
      this.test = test;
      this.numAn = 0;
      ref = this.test.map;
      for (i in ref) {
        s = ref[i];
        this.numAn++;
        this.answers[i] = this.answers[i] || false;
      }
      this.recover();
      this.score();
    }

    Answers.prototype.score = function() {
      var a, i, ref, s;
      s = 0;
      ref = this.answers;
      for (i in ref) {
        a = ref[i];
        if (a) {
          s++;
        }
      }
      s = (this.numAn - s) / this.numAn;
      console.log(s);
      return $('.score .calculated').html(Math.round(s * 100 * 100) / 100);
    };

    Answers.prototype.answer = function(i, b) {
      this.answers[i] = b;
      this.store();
      return this.score();
    };

    Answers.prototype.done = function(i) {
      return this.answer(i, true);
    };

    Answers.prototype.undone = function(i) {
      return this.answer(i, false);
    };

    Answers.prototype.toggle = function(i) {
      return this.answer(i, !this.get(i));
    };

    Answers.prototype.get = function(i) {
      return this.answers[i];
    };

    Answers.prototype.store = function() {
      var b, i, list, ref;
      list = [];
      ref = this.answers;
      for (i in ref) {
        b = ref[i];
        list[i - 1] = b ? 1 : 0;
      }
      return localStorage['answers_list'] = list;
    };

    Answers.prototype.recover = function() {
      var a, i, k, l, len, results;
      l = localStorage['answers_list'].split(',');
      results = [];
      for (i = k = 0, len = l.length; k < len; i = ++k) {
        a = l[i];
        results.push(this.answers[i + 1] = a === '1');
      }
      return results;
    };

    Answers.prototype.clear = function(all) {
      var d, i, j, ref, results, s;
      ref = this.test.map;
      for (i in ref) {
        s = ref[i];
        this.answers[i] = false;
      }
      if (all) {
        results = [];
        for (j in localStorage) {
          d = localStorage[j];
          if (j.search('answer') >= 0) {
            results.push(localStorage[j] = null);
          } else {
            results.push(void 0);
          }
        }
        return results;
      }
    };

    return Answers;

  })();

  this.mainAnswers = new Answers(mainTest);

}).call(this);
