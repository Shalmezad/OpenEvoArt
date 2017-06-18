require 'rubygems'
require 'chunky_png'
require_relative 'openevoart/artist'
require_relative 'openevoart/cgp_program'

def main
  # Let's test writing an image:
  artist = Artist.new
  png = artist.draw
  png.save('out/test.png')
  # Let's test evaluating a program:
  num_inputs = 2
  num_outputs = 2
  prog_arr = []
  # We'll have 2 nodes, 1 just returns x, 1 returns y
  prog_arr << [0, 1, 1] # Returns X (node 2)
  prog_arr << [0, 1, 2] # Returns Y (node 3)
  prog_arr << [3] # Output 1 = node 3 (Y)
  prog_arr << [2] # Output 2 = node 2 (X)
  prog_str = prog_arr.flatten.join(" ")
  prog = CGPProgram.new(prog_str, num_inputs, num_outputs)
  puts prog.evaluate([5,2])

end


main
