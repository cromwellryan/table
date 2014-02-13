# ===== Config =====
window.App = require 'config/app'
require 'config/router'

App.Store = FP.Store.extend
  firebaseRoot: "https://glaring-fire-8110.firebaseio.com"

# Load all modules in order automagically. Ember likes things to work this
# way so everything is in the App.* namespace.
folderOrder = [
  'initializers', 'utils', 'mixins', 'adapters', 'serializers', 'routes',
  'models', 'views', 'controllers', 'helpers', 'templates', 'components'
]

folderOrder.forEach (folder) ->
  # Go through the prefixes in order and require them
  window.require.list().filter((module) ->
    new RegExp("^#{folder}/").test(module)
  ).forEach((module) -> require(module))
