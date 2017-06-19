require_relative 'config'
class CGPProgram

  NUM_OPERATORS = 8

  def self.random_program(num_in, num_out, num_mid)
    # Alright, we need to build a random program:
    # So, let's build each of the middle ones:
    prog = []
    num_mid.times do |i|
      # Our index is actual num_in + i
      index = num_in + i
      # We can use any nodes before our index
      lhs = (rand() * index).to_i
      rhs = (rand() * index).to_i
      # And choose an operator:
      op = (rand() * NUM_OPERATORS).to_i
      # And add it to our program:
      prog << [lhs, rhs, op]
    end
    # Now, we need our outputs:
    num_out.times do |i|
      # Can be anything before the outputs:
      source = (rand() * (num_in + num_mid)).to_i
      prog << source
    end
    return prog.flatten.join(" ")
  end

  def initialize(str, num_inputs, num_outputs)
    @num_inputs = num_inputs
    @num_outputs = num_outputs
    # So, the string.
    # Based on Miller's paper, it's a series of numbers
    # So, let's split the string up first:
    tokens = str.split.map{|x|x.to_i}
    # Alright, now let's break it up into 2 pieces:
    # The last num_outputs tokens are for the output
    @output_sources = tokens.pop(num_outputs)
    # And the rest are grouped by 3:
    @middle_tokens = tokens.each_slice(3).to_a
    # Now, ahead of time, we're going to also allocate memory
    # We need a spot for each of our inputs, and middle tokens:
    @memory = Array.new(@num_inputs + @middle_tokens.size)
    if Config::debug_cgp
      puts "Loaded program:"
      puts "  Middle Tokens: "
      @middle_tokens.each do |mt|
        puts "    #{mt.join(" ")}"
      end
      puts "  Output sources: #{@output_sources.join(" ")}"
    end
  end

  def evaluate(inputs)
    # Alright, now the fun part.
    # First, load up our inputs:
    inputs.each_with_index do |input, index|
      @memory[index] = input
    end
    # Then evaluate each of our middle nodes:
    @middle_tokens.each_with_index do |node, index|
      @memory[index + @num_inputs] = evaluate_node(node)
    end
    if Config::debug_cgp
      puts "Memory: "
      puts "  " + @memory.join(" ")
    end

    # Finally, we'll get our outputs:
    outputs = @output_sources.map{|x| @memory[x]}
    # For sanity sake, we're going to limit to [0-1]
    # Sneaky clamp method:
    outputs = outputs.map{|o| [0, o, 1].sort[1] }
    return outputs
  end

  def evaluate_node(node)
    # A node is an array of 3 numbers:
    # First is left side:
    lhs = @memory[node[0]]
    # Second is right side:
    rhs = @memory[node[1]]
    # Third is operator:
    op = node[2]
    # Return based on the operator:
    result = 0
    if Config::debug_cgp
      puts "LHS: #{lhs}"
      puts "RHS: #{rhs}"
      puts "OP: #{op}"
    end
    # To help keep things under control, everything will be kept [0-1]
    if op == 0
      result = lhs
    elsif op == 1
      result = rhs
    elsif op == 2
      result = Math.sqrt(((lhs + rhs)/2).abs)
    elsif op == 3
      result = Math.sqrt((lhs-rhs).abs)
    elsif op == 4
      result = [lhs + rhs,1].min
    elsif op == 5
      result = (lhs-rhs).abs
    elsif op == 6
      result = (1-lhs).abs
    elsif op == 7
      result = (1-rhs).abs
    else
      raise "Unknown operator #{op}"
    end
    if Config::debug_cgp
      puts "Result: #{result}"
    end
    return [0, result, 1].sort[1]
  rescue => ex
    puts "Error:"
    puts "LHS: #{lhs}"
    puts "RHS: #{rhs}"
    puts "OP: #{op}"
    raise
  end
end
