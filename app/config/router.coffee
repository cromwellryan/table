module.exports = App.Router.map ->
  # put your routes here
  @resource "people", { path: '/' }
  @resource "person", { path: '/person/:person_id' }, ->
    @route "edit"