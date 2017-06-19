require 'chunky_png'
require_relative 'config'

class Critic
  attr_accessor :id
  attr_accessor :program

  @@last_used_critic_id = 1

  def initialize
    # 5 in (x,y,h,s,v), 1 out (rating)
    @program = CGPProgram.random_program(5,1,50)
    @id = @@last_used_critic_id
    @@last_used_critic_id += 1
  end

  def rate(image)
    total_rating = 0.0
    prog = CGPProgram.new(@program, 5, 1)
    Config::image_width.times do |x|
      Config::image_height.times do |y|
        xf = x.to_f / Config::image_width
        yf = y.to_f / Config::image_height
        pixel = image[x,y]
        hsv = ChunkyPNG::Color.to_hsv(pixel)
        o = prog.evaluate([xf, yf, hsv[0]/360.0, hsv[1], hsv[2]])
        total_rating += o[0]
      end
    end
    return total_rating / (Config::image_width * Config::image_height)
  end

end
