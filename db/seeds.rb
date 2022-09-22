# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'uri'
require 'json'
puts 'Cleaning database'
Movie.destroy_all
puts 'Creating movies'

url = 'https://tmdb.lewagon.com/movie/top_rated'
serialized_url = URI.parse(url).read
json_response = JSON.parse(serialized_url)

json_response['results'].each do |result|
  Movie.create!(
    title: result['title'],
    overview: result['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{result['poster_path']}",
    rating: result['vote_average']
  )
  p "#{result['title']} has been added to the DB."
end

puts 'Finished!'
