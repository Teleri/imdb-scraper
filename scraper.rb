require 'open-uri'
require 'nokogiri'

USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"

def fetch_movie_urls
  top_url = 'https://www.imdb.com/chart/top/'
  read_url = Nokogiri::HTML.parse(URI.parse(top_url).open("Accept-Language" => "en-US", "User-Agent" => USER_AGENT).read)
  movies = read_url.search('.ipc-title-link-wrapper')
  movies.take(5).map do |movie|
    # "https://www.imdb.com/title/tt0111161/
    uri = URI.parse(movie.attributes["href"].value)
    uri.scheme = "https"
    uri.host = "www.imdb.com"
    uri.query = nil
    uri.to_s
  end
end

def scrape_movie(url)
  doc = Nokogiri::HTML.parse(URI.parse(url).open("Accept-Language" => "en-US", "User-Agent" => USER_AGENT).read)
  title = doc.search('h1').text.strip
  year = doc.search(".sc-dffc6c81-0 ul li a").text.to_i
  storyline = doc.search(".sc-466bb6c-1").text
  director = doc.search('.ipc-metadata-list__item:contains("Director") a').first.text
  cast = doc.search('.ipc-metadata-list__item:contains("Stars") a.ipc-metadata-list-item__list-content-item').map { |element| element.text }.uniq

  {
    title: title,
    storyline: storyline,
    director: director,
    cast: cast,
    year: year
  }
end

scrape_movie('https://www.imdb.com/title/tt21811606/')
