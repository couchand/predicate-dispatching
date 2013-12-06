# predicate dispatching example

class Dispatcher
  constructor: ->
    @methods = {}

  register: (name, fn, pred) ->
    unless name of @methods
      @methods[name] = []
    @methods[name].push([fn, pred])

  dispatch: (name, args) ->
    throw "no method found" unless name of @methods
    for [fn, pred] in @methods[name]
      if pred.apply(null, args)
        return fn.apply(null, args)
    throw "no candidate matched"

  dispatcher: (name) ->
    throw "no method found" unless name of @methods
    t = @
    ->
      t.dispatch(name, arguments)

module.exports = -> new Dispatcher()
