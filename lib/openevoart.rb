require 'rubygems'
require 'chunky_png'
require_relative 'openevoart/artist'
require_relative 'openevoart/critic'
require_relative 'openevoart/cgp_program'

# For making wallpapers:
# ex: redraw_image("out/#{i}.txt")
def redraw_image(file)
  artist = Artist.new
  artist.program = open(file).read
  png = artist.draw
  png.save("out/redrawn.png")
end

def main
  # Let's test writing an image:
  critic = Critic.new
  100.times do
    artist = Artist.new
    png = artist.draw
    png.save("out/#{artist.id}.png")
    open("out/#{artist.id}.txt", "w"){|f| f << artist.program}
    rating = critic.rate(png)
    puts "#{artist.id} rating: #{rating}"
  end

end


main
