require 'rubygems'
require 'chunky_png'

def main
  puts "Hello world"
  # Let's test writing an image:
  # From the chunky_png documentation
  png = ChunkyPNG::Image.new(16,16, ChunkyPNG::Color::TRANSPARENT)
  png[1,1] = ChunkyPNG::Color.rgba(10,20,30,128)
  png.save('out/test.png')
end


main
