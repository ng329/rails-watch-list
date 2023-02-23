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
# user_serialized = URI.open(url).read

(1..20).each do |n|
  movies_serialized = URI.open("#{url}?page=#{n}").read
  movies = JSON.parse(movies_serialized)['results']
  movies.each do |movie|
    title = movie['title']
    overview = movie['overview']
    poster_url = "https://image.tmdb.org/t/p/original#{movie['poster_path']}"
    rating = movie['vote_average']
    Movie.create(title: title, overview: overview, poster_url: poster_url, rating: rating)
  end
  puts "#{n}"
end

# List.create(name: "sci-fi", photo: "")
# List.create(name: "fantasy", photo: "")
# List.create(name: "Drama", photo: "https://media.glamour.com/photos/5ec2e91dccfbc8c1a8fe8cbf/master/w_3000,h_2032,c_limit/MSDTITA_FE057.jpg")
