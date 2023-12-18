require "httparty"
require "nokogiri"
response = HTTParty.get("https://www.serebii.net/pokedex-sv/ogron/")
document = Nokogiri::HTML(response.body)
puts document.title