require 'yaml'
require_relative 'scraper'

url = fetch_movie_urls

movies = url.map do |url|
  scrape_movie(url)
end

File.write('movies.yml', movies.to_yaml)
