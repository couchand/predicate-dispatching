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
isCoincident = (d) -> @distance(d) is 0

pcls.register "distance",
  [["you", isPoint]],
  ->
    xd = @x - @you.x
    yd = @y - @you.y
    Math.sqrt(xd*xd + yd*yd)

pcls.register "midpoint",
  [["you", isCoincident]],
  ->
    @you

pcls.register "midpoint",
  [["you", isPoint]],
  ->
    point(
      (@x + @you.x)/2,
      (@y + @you.y)/2
    )

point = (x, y) ->
  p = { x: x, y: y }
  p.distance = pcls.dispatcher("distance", p)
  p.midpoint = pcls.dispatcher("midpoint", p)
  p

console.log point(0, 1).distance(point(1, 0))
console.log point(0, 1).midpoint(point(0, 1))
console.log point(0, 1).midpoint(point(1, 0))
