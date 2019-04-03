# require 'pry'

class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs, :genre

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end

  def add_song(song)
    if song.artist != self
    song.artist = self
    end
    if !(@songs.include?(song))
    @songs << song
    end
  end

  def songs
    @songs
  end

  # binding.pry

  # def genres
  #   self.songs.map do |song|
  #     if song.genre != self
  #       song.genre = self
  #     end
  #   end
  #   self.songs.genre.uniq
  # end
  def genres
    self.songs.collect {|song| song.genre}.uniq
  end

  #  def self.find_or_create_by_name(name)
  #   @@all.each do |artist|
  #     if artist.name == name
  #       return artist
  #     end
  #   end
  #   new(name).save
  # end

end
