@googleUser = {}

@startApp = ->
  gapi.load 'auth2', ->
    # Retrieve the singleton for the GoogleAuth library and set up the client.
    @auth2 = gapi.auth2.init(
      client_id: '951761439229-2k8p8k4fcvioun5fm40rjo32g32eih6e.apps.googleusercontent.com'
      cookiepolicy: 'single_host_origin')
    attachSignin $('.googleAuth')[0]
    return
  return

@attachSignin = (element) ->
  auth2.attachClickHandler element, {}, ((googleUser) ->
    $('.name').html('Signed in: ' + googleUser.getBasicProfile().getName())
    return
  ), (error) ->
    alert JSON.stringify(error, undefined, 2)
    return
  return