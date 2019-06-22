class Artist

  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(item)
    self.new(item)
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    if song.artist == self
      return song.artist
    else
      song.artist = self
    end
  end

  def genres
    @songs.collect {|song| song.genre}.uniq
  end

end
