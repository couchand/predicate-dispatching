# test

sys = require("./prdi")()

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
