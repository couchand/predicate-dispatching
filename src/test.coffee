# test

dispatcher = require("./prdi")
sys = dispatcher()

isNegative = (d) -> d < 0
isNatural = (d) -> d >= 0

sys.register "abs",
  [["d", isNegative]],
  -> -@d

sys.register "abs",
  [["d", isNatural]],
  -> @d

abs = sys.dispatcher("abs")

console.log abs 5
console.log abs -5

# oop?

pcls = dispatcher()

isPoint = (p) -> p.x? and p.y?

pcls.register "distance",
  [["you", isPoint]],
  ->
    xd = @x - @you.x
    yd = @y - @you.y
    Math.sqrt(xd*xd + yd*yd)

point = (x, y) ->
  p = { x: x, y: y }
  p.distance = pcls.dispatcher("distance", p)
  p

console.log point(0, 1).distance(point(1, 0))
