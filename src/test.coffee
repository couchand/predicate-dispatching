# test

sys = require("./prdi")()

sys.register "abs",
  (d) -> d,
  (d) -> d >= 0

sys.register "abs",
  (d) -> -d,
  (d) -> d < 0

abs = sys.dispatcher("abs")

console.log abs 5
console.log abs -5
