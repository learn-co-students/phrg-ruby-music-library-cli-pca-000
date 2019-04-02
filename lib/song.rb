class Song
  attr_reader :genre, :artist
  attr_accessor :name, :filename

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) unless artist == nil
    self.genre=(genre) unless genre == nil
  end

  def name
    @name
  end

  def name=(song)
    @name= song
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

  def self.create(song, artist=nil, genre=nil)
    new_song = Song.new(song,artist, genre)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.songs << self unless
    genre.songs.include?(self)
  end

  def self.find_by_name(song)
    self.all.detect { |instance| instance.name == song }
  end

  def self.find_or_create_by_name(song)
    find_by_name(song) || create(song)
  end

  def self.new_from_filename(song)
    song_file = song.split(" - ")
    song_name = song_file[1]
    artist = Artist.find_or_create_by_name(song_file[0])
    genre = Genre.find_or_create_by_name(song_file[2].split('.')[0])
    self.create(song_name, artist, genre)
  end

  def self.create_from_filename(song)
    self.new_from_filename(song)
  end








end
