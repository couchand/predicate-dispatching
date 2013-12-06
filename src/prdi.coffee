# predicate dispatching example

class Dispatcher
  constructor: ->
    @methods = {}

  register: (name, params, fn) ->
    unless name of @methods
      @methods[name] = []
    unless params.length of @methods[name]
      @methods[name][params.length] = []
    @methods[name][params.length].push([params, fn])

  dispatch: (name, args) ->
    throw "no method found" unless name of @methods
    throw "airity mismatch" unless args.length of @methods[name]
    for [params, fn] in @methods[name][args.length]
      isThis = yes
      context = {}
      for i in [0...args.length]
        context[params[i][0]] = args[i]
        isThis = isThis and params[i][1].apply(null, [args[i]])
      if isThis
        return fn.apply(context)
    throw "no candidate matched"

  dispatcher: (name) ->
    throw "no method found" unless name of @methods
    t = @
    ->
      t.dispatch(name, arguments)

module.exports = -> new Dispatcher()
