require 'pry'

class Song
  extend Concerns::Findable

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = (artist) if artist != nil
    self.genre = (genre) if genre != nil
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

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
    # binding.pry
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.new_from_filename(file)
    split = file.gsub(".mp3", "").split(" - ")
    artist = Artist.find_or_create_by_name(split[0])
    genre = Genre.find_or_create_by_name(split[2])
    self.new(split[1], artist, genre)
  end

  def self.create_from_filename(name)
    song = self.new_from_filename(name)
    song.save
  end
end
