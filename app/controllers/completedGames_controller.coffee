module.exports = App.CompletedGamesController = Ember.ArrayController.extend
  needs: ['game']
  actions:
    removeGame: (game) ->
      game.delete()
  games: (->
    @get('content').map((game) ->
      hs = game.get('homeScore')
      as = game.get('awayScore')
      game.set('homeWinner', hs > as)
      game.set('awayWinner', as > hs)
      completed = game.get('completedAt')
      game.set('date', moment(completed).fromNow())
      game
    ).reverse()
  ).property('content.@each')
