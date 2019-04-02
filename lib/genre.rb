require 'pry'

class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs =[]
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

  def artists
    self.songs.map { |genre| genre.artist }.uniq
  end

  def self.create(genre_name)
    genre = Genre.new(genre_name)
    genre.save
    genre
  end

end
