require 'chunky_png'
require_relative 'config'

class Artist
  def initialize
    # Make a random program string:
    prog = []
    prog << [0,1,1] # Returns X (node 2)
    prog << [0,1,2] # Returns Y (node 3)
    prog << [3] # Output 1 = node 3 (Y)
    prog << [3] # Output 2 = node 3 (Y)
    prog << [2] # Output 3 = node 2 (X)
    @program = prog.flatten.join(" ")
  end

  # Returns a chunky_png image
  def draw
    prog = CGPProgram.new(@program, 2, 3)
    png = ChunkyPNG::Image.new(Config::image_width,
                               Config::image_height, 
                               ChunkyPNG::Color::TRANSPARENT)
    Config::image_width.times do |x|
      Config::image_height.times do |y|
        # Takes in X,Y, gives HSL
        # For sanity sake, putting X/Y in terms of 0-1
        xf = x.to_f / Config::image_width
        yf = y.to_f / Config::image_height
        o = prog.evaluate([xf, yf])
        # Now, from the chunky_png docs,
        # Hue is 0-360:
        h = o[0] * 360
        # Sat is 0-1
        s = o[1]
        # Val is 0-1
        v = o[2]
        png[x,y] = ChunkyPNG::Color.from_hsv(h,s,v)
      end
    end
    return png
  end
end
