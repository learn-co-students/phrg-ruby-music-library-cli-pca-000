class Artist
  extend Concerns::Findable
  attr_accessor :name, :artist, :song

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  # def name
  #   @name
  # end

  def self.create(name)
    created_artist = Artist.new(name)
    created_artist.save
    created_artist
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)
  end

  def genres
    self.songs.collect do |song|
    song.genre
    end.uniq
  end

end
