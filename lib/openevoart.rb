require 'rubygems'
require 'chunky_png'
require_relative 'openevoart/artist'
require_relative 'openevoart/critic'
require_relative 'openevoart/cgp_program'

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
=begin
  # For taking and making wallpapers:
  good_ones = [100, 95, 51, 25, 9]
  good_ones.each do |i|
    puts "Making: #{i}"
    artist = Artist.new
    artist.program = open("out/#{i}.txt").read
    png = artist.draw
    png.save("out/cgp_#{i}.png")
  end
=end



end


main
