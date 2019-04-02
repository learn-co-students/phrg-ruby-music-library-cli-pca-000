require 'pry'

class MusicLibraryController
  # extend Concerns::Findable

  attr_accessor :path

  def initialize(path = './db/mp3s')
    muzik = MusicImporter.new(path)
    muzik.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    while (input = gets) != 'exit'
      puts input
      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    sort_by_name(Song.all).each_with_index do |song, order|
      puts "#{order+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sort_by_name(Artist.all).each_with_index do |artist, order|
      puts "#{order+1}. #{artist.name}"
    end
  end

  def list_genres
    sort_by_name(Genre.all).each_with_index do |genre, order|
      puts "#{order+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    an_artist = gets
    artist = Artist.find_by_name(an_artist)
    if artist
      sort_by_name(artist.songs).each_with_index do |song, order|
        puts "#{order+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def sort_by_name(collection)
    collection.sort_by {|item| item.name}
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    a_genre = gets
    if genre = Genre.find_by_name(a_genre)
      genre.songs.sort_by {|genre| genre.name}.each_with_index { |song, order|
        puts "#{order+1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.to_i
    Song.all.sort_by{|song| song.name}.each_with_index do |song, order|
      if (order+1) == input
        puts "Playing #{song.name} by #{song.artist.name}"
        # binding.pry
      end
    end
  end
end
