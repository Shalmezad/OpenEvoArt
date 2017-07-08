require 'rubygems'
require 'chunky_png'
require_relative 'openevoart/artist'
require_relative 'openevoart/critic'
require_relative 'openevoart/cgp_program'
require_relative 'openevoart/open_evo'

# For making wallpapers:
# ex: redraw_image("out/#{i}.txt")
def redraw_image(file)
  artist = Artist.new
  artist.program = open(file).read
  png = artist.draw
  png.save("out/redrawn.png")
end

def main
  oe = OpenEvo.new
  100000.times do
    oe.step
  end
end

main
