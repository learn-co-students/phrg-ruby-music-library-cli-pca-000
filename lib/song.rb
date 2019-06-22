class Song

  extend Concerns::Findable

  attr_accessor :name, :genre
  attr_reader :artist


  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
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
    song = new(item)
    song.save
    song
  end

  def self.new_from_filename(filename)
    song = filename.split(" - ")
    song_artist, song_title, song_genre = song[0], song[1], song[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(song_artist)
    genre = Genre.find_or_create_by_name(song_genre)
    Song.new(song_title, artist, genre)
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end

end
