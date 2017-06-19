class Config

  # Initial queue sizes
  def self.critic_start_size
    return 10
  end

  def self.artist_start_size
    return 10
  end

  def self.critic_min_size
    return 3
  end

  def self.artist_min_size
    return 3
  end

  def self.critic_max_size
    return 20
  end

  def self.artist_max_size
    return 20
  end

  def self.image_width
    #return 160
    return 144
    #return 2880
  end

  def self.image_height
    #return 160
    return 90
    #return 1800
  end

  def self.debug_cgp
    return false
  end
end
