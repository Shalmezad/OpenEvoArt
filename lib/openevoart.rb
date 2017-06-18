require 'rubygems'
require 'chunky_png'
require_relative 'openevoart/artist'

def main
  # Let's test writing an image:
  artist = Artist.new
  png = artist.draw
  png.save('out/test.png')
end


main
