App.AuthController = Ember.Controller.extend
  needs: ['people', 'person']
  isAuthed: false
  userId: 0
  isAdmin: false
  authRoot: TAPAS_ENV.db
  isNotAuthorized: false
  getAllows: (->
    ref = new Firebase(@get('authRoot'))
    allow = ref.child('allowed')
    @set('allowData', allow)
    allow.on('value', (list) =>
      @set('allowed', list.val())
    )
  ).on('init')
  setupAuth:( ->
    slRef = new Firebase(@get('authRoot'))
    @authClient = new FirebaseSimpleLogin(slRef, (err, user) =>
      if !err && user
        @pickUser(user)
    )
  ).on('init')
  pickUser: (user) ->
    @get('store').fetch('person', user.id).then ((person) =>
      photo = "http://thetable.io/img/def.jpg"
      if user.profile_image_url
        photo = user.profile_image_url
      person.setProperties(
        name: user.name
        twitter: user.username
        avatar: photo
      )
      person.save()
      @set('isAdmin', person.get('isAdmin'))
      @set('person', person)
    ), (error) =>
      allowlist = @get('allowed')
      if allowlist.indexOf(user.username) < 0
        @set('isNotAuthorized', true)
        return
      newPerson = @get('store').createRecord("person",
        id: user.id
        name: user.name
        twitter: user.username
        email: ''
        isWaiting: false
        isModerator: false
        isAdmin: false
        createdAt: new Date()
        wins: 0
        losses: 0
        avatar: user.photos[0].value
      )
      newPerson.save().then ((person) =>
        @set('person', person)
      )

  login: ->
    @authClient.login('twitter', { rememberMe: true } )
    
  logout: ->
    @authClient.logout()
    @set('person', undefined)
