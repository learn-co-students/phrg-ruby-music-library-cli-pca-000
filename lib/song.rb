class Song
  attr_accessor :name, :artist, :genre
  @@all = []
  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil
      self.artist = artist
    end
    if genre != nil
      self.genre = genre
    end
  end

  def artist=(artist)
      @artist = artist
      artist.add_song(self)
  end

  def genre=(genre)
      @genre = genre
      genre.add_song(self)
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
    song = new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    self.all.find{ |song| song.name == name }
  end

   def self.find_or_create_by_name(name)
    find_by_name(name)|| create(name)
  end

  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name = parts[0]
    song_name = parts[1].gsub(".mp3", "")
    genre_name = parts[2].gsub(".mp3", "")
    # song.name = song_name
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = self.new(song_name, artist, genre)
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save }
  end

end
