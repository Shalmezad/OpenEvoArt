require 'chunky_png'
require_relative 'config'

class Artist

  attr_accessor :id
  attr_accessor :program

  @@last_used_artist_id = 1
  def initialize
    # Make a random program string:
    @program = CGPProgram.random_program(2,3,Config::middle_node_count)
    @id = @@last_used_artist_id
    @@last_used_artist_id += 1
  end

  # Returns a chunky_png image
  def draw
    if @cache.nil?
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
          if Config::use_hsv
            # Now, from the chunky_png docs,
            # Hue is 0-360:
            h = o[0] * 360
            # Sat is 0-1
            s = o[1]
            # Val is 0-1
            v = o[2]
            png[x,y] = ChunkyPNG::Color.from_hsv(h,s,v)
          else
            r = (o[0] * 255).to_i
            g = (o[1] * 255).to_i
            b = (o[2] * 255).to_i
            png[x,y] = ChunkyPNG::Color.rgb(r,g,b)
          end
        end
      end
      @cache = png
    end
    return @cache
  end
end
