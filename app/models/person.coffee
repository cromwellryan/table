App.Person = FP.Model.extend(
  name: FP.attr()
  email: FP.attr()
)

###
App.Person.FIXTURES = [
  {
    id: 1
    name: 'Patrick Simpson'
    email: 'izerop@gmail.com'
  },
  {
    id: 2
    name: 'Sizzle Pea'
    email: 'patrick@heysparkbox.com'
  }
]
###
