(function() {
  this.bound = function(num, low, high) {
    return Math.max(low, Math.min(high, num));
  };

}).call(this);
