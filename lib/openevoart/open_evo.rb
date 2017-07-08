require_relative 'config'
class OpenEvo
  def initialize(critic_start_size = Config::critic_start_size, artist_start_size = Config::artist_start_size)
    @critic_pool = []
    @artist_pool = []

    critic_start_size.times do |i|
      @critic_pool << Critic.new
    end

    artist_start_size.times do |i|
      @artist_pool << Artist.new
    end
  end

  def step
    run_artist_step
    run_critic_step
  end

  def run_artist_step
    # dequeue an artist:
    artist = @artist_pool.shift
    # draw
    art = artist.draw
    # save:
    art.save("out/art/#{artist.id}.png")
    open("out/art/#{artist.id}.txt","w"){|f|f << artist.program}
    # See if we have a positive rating:
    positive_rating = !@critic_pool.detect{|c|c.rate(art) > 0.5}.nil?
    # If we have a positive rating, we can move on:
    if positive_rating
      puts "Art moving on"
      # Make a child:
      new_prog = CGPProgram.mutate(artist.program, 2,3, Config::mutate_chance)
      new_artist = Artist.new
      new_artist.program = new_prog
      @artist_pool << new_artist
      # Should we put ourselves on?
      if @artist_pool.size < Config::artist_max_size
        @artist_pool << artist
      end
    else
      puts "Starving artist passed away"
    end

    # Do we need genesis?
    while @artist_pool.size < Config::artist_min_size do
      puts "Not enough artists!"
      @artist_pool << Artist.new
    end

  end

  def run_critic_step
    # dequeue a critic
    critic = @critic_pool.shift
    # We're going to see if we're a fair critic
    has_positive = false
    has_negative = false
    # Go through each of our artists:
    @artist_pool.each do |artist|
      rating = critic.rate(artist.draw)
      if rating > 0.5
        has_positive = true
      elsif rating < 0.5
        has_negative = true
      end
      # If we were fair, we're done:
      if has_positive && has_negative
        break
      end
    end
    # If we were fair, we can move on:
    if has_positive && has_negative
      puts "Critic moving on"
      # Make a child:
      new_prog = CGPProgram.mutate(critic.program, 5,1, Config::mutate_chance)
      new_critic = Critic.new
      new_critic.program = new_prog
      @critic_pool << new_critic
      # Should we put ourselves on?
      if @critic_pool.size < Config::critic_max_size
        @critic_pool << critic
      end

    elsif has_positive
      puts "Critic liked everything, useless"
    elsif has_negative
      puts "Critic disliked everything, useless"
    else
      puts "Critic is unsure rock, useless"
    end

    # Do we need genesis?
    while @critic_pool.size < Config::critic_min_size do
      puts "Not enough critics!"
      @critic_pool << Critic.new
    end


  end


end
