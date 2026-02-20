import system
import strformat
import math
import sequtils

const WIDTH  = 512
const HEIGHT = 512

type RGB = tuple[r: float, g: float, b: float]

type Vec2 = tuple[x: float, y: float]

proc vec2(s: float): Vec2 = (s, s)
proc `+`(a, b: Vec2): Vec2 = (a.x + b.x, a.y + b.y)
proc `-`(a, b: Vec2): Vec2 = (a.x - b.x, a.y - b.y)
proc `*`(a, b: Vec2): Vec2 = (a.x * b.x, a.y * b.y)
proc `/`(a, b: Vec2): Vec2 = (a.x / b.x, a.y / b.y)
proc length(a: Vec2): float = sqrt(a.x * a.x + a.y * a.y)

proc stripes(uv: Vec2): RGB =
  let n = 8.0
  (
    (sin(uv.x * n) + 1.0) * 0.5,
    (sin((uv.x + uv.y * (n * n)) * n * 660.0) + 1.0) * 0.5,
    # 0.59,
    (cos(uv.y * n + 0.2) + 1.0) * 0.5
  )

proc circle(uv: Vec2): RGB =
  let a = (vec2(0.5) - uv).length > 0.25
  (1.0, float(a), float(a))

proc wang(uv: Vec2): RGB =
  let r = 0.5
  let cs = @[(0.5, 0.0), (0.5, 1.0)]
  let ps = cs.map(proc(c: Vec2): RGB = (float((cs[0] - uv).length < r), 0.0, 0.0))
  ps[0]

proc main(): void =
  let f = open("output.ppm", fmWrite)
  defer: f.close()
  f.writeLine("P6")
  f.writeLine(fmt"{WIDTH} {HEIGHT} 255")
  for x in 0..<HEIGHT:
    for y in 0..<WIDTH:
      let u = float(y) / float(WIDTH)
      let v = float(x) / float(WIDTH)
      let (r, g, b) = wang((u, v))
      f.write(chr(int(r * 255.0)))
      f.write(chr(int(g * 255.0)))
      f.write(chr(int(b * 255.0)))

when isMainModule:
  main()
