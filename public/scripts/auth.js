(function() {
  this.googleUser = {};

  this.startApp = function() {
    gapi.load('auth2', function() {
      this.auth2 = gapi.auth2.init({
        client_id: '951761439229-2k8p8k4fcvioun5fm40rjo32g32eih6e.apps.googleusercontent.com',
        cookiepolicy: 'single_host_origin'
      });
      attachSignin($('.googleAuth')[0]);
    });
  };

  this.attachSignin = function(element) {
    auth2.attachClickHandler(element, {}, (function(googleUser) {
      $('.name').html('Signed in: ' + googleUser.getBasicProfile().getName());
    }), function(error) {
      alert(JSON.stringify(error, void 0, 2));
    });
  };

}).call(this);
