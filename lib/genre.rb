class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def name
    @name
  end
  def name=(genre)
    @name = genre
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
  def self.create(genre)
    genre = Genre.new(genre)
    genre.save
    genre
  end

  def add_song(song)
    self.songs << song unless @songs.include?(song)
    self.artist << song.artist unless @songs.include?(song)
    song.genre = self if song.genre.nil?
  end

  def artists
   artists =  self.songs.collect do |song|
    song.artist
  end
    artists.uniq
  end



end
