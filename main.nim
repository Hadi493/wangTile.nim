import system
import strformat
import math

const WIDTH  = 1920
const HEIGHT = 1080

type RGB = tuple[r: float, g: float, b: float]

proc stripes(u, v: float): RGB =
  let n = 17.0
  (
    (sin(u * n) + 1.0) * 0.5,
    (cos(v * n) + 1.0) * 0.5,
    0.99
  )

# proc circle(u, v: float): RGB =


proc main(): void =
  let f = open("output.ppm", fmWrite)
  defer: f.close()
  f.writeLine("P6")
  f.writeLine(fmt"{WIDTH} {HEIGHT} 255")
  for x in 0..<HEIGHT:
    for y in 0..<WIDTH:
      let u = float(y) / float(WIDTH)
      let v = float(x) / float(WIDTH)
      let (r, g, b) = stripes(u, v)
      f.write(chr(int(r * 255.0)))
      f.write(chr(int(g * 255.0)))
      f.write(chr(int(b * 255.0)))

when isMainModule:
  main()
