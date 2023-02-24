# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"

puts 'clearing database'
Bookmark.delete_all
List.delete_all
Movie.delete_all
puts 'finished clearing database'

puts 'adding movies'

url = 'http://tmdb.lewagon.com/movie/top_rated'

# pages are identical if change number?
movies_serialized = URI.open("#{url}?page=1").read
movies = JSON.parse(movies_serialized)['results']
movies.each do |movie|
  title = movie['title']
  overview = movie['overview']
  poster_url = "https://image.tmdb.org/t/p/original#{movie['poster_path']}"
  rating = movie['vote_average']
  movie =  Movie.new(title: title, overview: overview, poster_url: poster_url, rating: rating)
  movie.save
  puts movie.title.to_s
end

# List.create(name: "sci-fi", photo: "")
# List.create(name: "fantasy", photo: "")
# List.create(name: "Drama", photo: "")
