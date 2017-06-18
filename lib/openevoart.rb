require 'rubygems'
require 'chunky_png'
require_relative 'openevoart/artist'
require_relative 'openevoart/cgp_program'

def main
  # Let's test writing an image:
  10.times do
    artist = Artist.new
    png = artist.draw
    png.save("out/#{artist.id}.png")
  end

end


main
