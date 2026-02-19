import system
import strformat
import math

const WIDTH  = 555
const HEIGHT = 555

type RGB = tuple[r: float, g: float, b: float]

type Vec2 = tuple[x: float, y: float]

proc vec2(s: float): Vec2 = (s, s)
proc `+`(a, b: Vec2): Vec2 = (a.x + b.x, a.y + b.y)
proc `-`(a, b: Vec2): Vec2 = (a.x - b.x, a.y - b.y)
proc `*`(a, b: Vec2): Vec2 = (a.x * b.x, a.y * b.y)
proc `/`(a, b: Vec2): Vec2 = (a.x / b.x, a.y / b.y)
proc length(a: Vec2): float = sqrt(a.x * a.x + a.y * a.y)

proc stripes(uv: Vec2): RGB =
  let n = 17.0
  (
    (sin(uv.x * n) + 1.0) * 0.5,
    (sin((uv.x + uv.y) * n) + 1.0) * 0.5,
    (cos(uv.y * n) + 1.0) * 0.5
  )

proc circle(uv: Vec2): RGB =
  let a = (vec2(0.5) - uv).length > 0.25
  (1.0, float(a), float(a))

proc main(): void =
  let f = open("output.ppm", fmWrite)
  defer: f.close()
  f.writeLine("P6")
  f.writeLine(fmt"{WIDTH} {HEIGHT} 255")
  for x in 0..<HEIGHT:
    for y in 0..<WIDTH:
      let u = float(y) / float(WIDTH)
      let v = float(x) / float(WIDTH)
      let (r, g, b) = circle((u, v))
      f.write(chr(int(r * 255.0)))
      f.write(chr(int(g * 255.0)))
      f.write(chr(int(b * 255.0)))

when isMainModule:
  main()
