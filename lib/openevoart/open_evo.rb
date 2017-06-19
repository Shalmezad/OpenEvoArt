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
    # TODO: code me!
  end


end
