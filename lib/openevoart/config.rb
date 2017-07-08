class Config
  WallpaperMini = [144,90]
  WallpaperFull = [2880, 1800]
  Youtube240 = [426, 240]
  DebugSize = [3, 3]

  # Pick one of the above:
  SizeConfig = WallpaperMini

  def self.image_width
    SizeConfig[0]
  end

  def self.image_height
    SizeConfig[1]
  end


  # Initial queue sizes
  def self.critic_start_size
    return 2
  end

  def self.artist_start_size
    return 4
  end

  def self.critic_min_size
    return 2
  end

  def self.artist_min_size
    return 3
  end

  def self.critic_max_size
    return 4
  end

  def self.artist_max_size
    return 8
  end

  def self.mutate_chance
    return 0.05
  end

  def self.middle_node_count
    return 20
  end


  def self.debug_cgp
    return false
  end
end
