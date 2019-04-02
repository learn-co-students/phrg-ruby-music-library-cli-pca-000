#require 'pry'

class MusicLibraryController

  def initialize(path='./db/mp3s')
    importer = MusicImporter.new(path)
    importer.import
  end

def call
  puts "Welcome to your music library!"
  puts "To list all of your songs, enter 'list songs'."
  puts "To list all of the artists in your library, enter 'list artists'."
  puts "To list all of the genres in your library, enter 'list genres'."
  puts"To list all of the songs by a particular artist, enter 'list artist'."
  puts "To list all of the songs of a particular genre, enter 'list genre'."
  puts "To play a song, enter 'play song'."
  puts "To quit, type 'exit'."
  puts "What would you like to do?"

  user_input = gets.chomp
   while user_input != "exit"

    if user_input == "list songs"
        list_songs

    elsif user_input == "list artists"
        list_artists

    elsif user_input == "list genres"
        list_genres

     elsif user_input == "list artist"
        list_songs_by_artist

      elsif user_input == "list genre"
        list_songs_by_genre

    elsif user_input == "play song"
      puts "Which song number?"
      user_input = gets
        play_song(user_input.to_i)

    elsif user_input == "list artist"
      puts "Which artist?"
      user_input = gets
        artist_songs(user_input)

    elsif user_input == "list genre"
      puts "Which genre?"
      user_input = gets
        genre_songs(user_input)
      end

       user_input = gets
    end
  end

  def list_songs
     Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index{|song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.sort{|a,b| a.name <=> b.name}.each_with_index{|artist, index|
      puts "#{index+1}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort{|a,b| a.name <=> b.name}.each_with_index{|genre,index|
      puts "#{index+1}. #{genre.name}"}
  end

  def list_songs_by_artist
   puts "Please enter the name of an artist:"
    input = gets.chomp
    if artist = Artist.find_by_name(input)
      artist.songs.sort{|a,b| a.name <=> b.name}.each_with_index{ |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"}
      end
    end
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    if genre = Genre.find_by_name(input)
      genre.songs.sort{|a,b| a.name <=> b.name}.each_with_index{|song,index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"}
      end
    end


    def play_song
    puts "Which song number would you like to play?"
      input = gets.chomp.to_i  #input to be 1 through size of Song.all
    if input.between?(1,Song.all.length)
      song = Song.all.sort{ |a,b| a.name <=> b.name}[input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end










