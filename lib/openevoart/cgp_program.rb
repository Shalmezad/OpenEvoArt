require_relative 'config'
class CGPProgram
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
    if op == 1
      result = lhs
    elsif op == 2
      result = rhs
    elsif op == 3
      result = Math.sqrt(lhs + rhs)
    else
      raise "Unknown operator #{op}"
    end
    if Config::debug_cgp
      puts "Result: #{result}"
    end
    return result
  end
end
