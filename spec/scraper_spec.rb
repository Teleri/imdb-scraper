require_relative "../scraper"

describe "#fetch_movie_urls" do
  it "returns array of movies" do
    expected_result = [
      "https://www.imdb.com/title/tt0111161/",
      "https://www.imdb.com/title/tt0068646/",
      "https://www.imdb.com/title/tt0468569/",
      "https://www.imdb.com/title/tt0071562/",
      "https://www.imdb.com/title/tt0050083/"
    ]
    expect(fetch_movie_urls).to eq(expected_result)
  end
end

describe "#scrape_movie" do
  it "returns a hash describing the movie" do
    the_dark_knight_url = "https://www.imdb.com/title/tt0468569/"
    movie = scrape_movie(the_dark_knight_url)

    result = {
      title: "The Dark Knight",
      storyline: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      director: "Christopher Nolan",
      cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
      year: 2008
    }
    expect(movie).to eq(result)
  end

end
