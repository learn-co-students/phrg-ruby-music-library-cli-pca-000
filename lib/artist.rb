require 'pry'

class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
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

  def add_song(song)
    if @songs.include?(song)
      nil
    else
      @songs << song
    end
    if song.artist.nil?
      song.artist = self
    end
    # binding.pry
  end

  def genres
    self.songs.map { |song| song.genre }.uniq
  end

  def self.create(artist_name)
    artist = Artist.new(artist_name)
    artist.save
    artist
  end

end
