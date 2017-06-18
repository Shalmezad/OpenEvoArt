require 'chunky_png'
require_relative 'config'

class Artist

  # Returns a chunky_png image
  def draw
    png = ChunkyPNG::Image.new(Config::image_width,
                               Config::image_height, 
                               ChunkyPNG::Color::TRANSPARENT)
    # TODO: Code me
    png[1,1] = ChunkyPNG::Color.rgba(10,20,30,128)
    return png
  end
end
