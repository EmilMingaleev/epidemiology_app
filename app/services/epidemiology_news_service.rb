require 'net/http'
require 'json'
require 'uri'
require 'cgi'

class EpidemiologyNewsService
  API_KEY = '70b2b9a420244523b6b3e30780e1033f'

  def self.fetch_epidemiology_news
    query = 'эпидемиология'
    encoded_query = CGI.escape(query)
    url = URI("https://newsapi.org/v2/everything?q=#{encoded_query}&language=ru&apiKey=#{API_KEY}")
    response = Net::HTTP.get(url)
    JSON.parse(response)['articles'].first(3)
  end

  def self.fetch_hiv_news
    query = 'ВИЧ'
    encoded_query = CGI.escape(query)
    url = URI("https://newsapi.org/v2/everything?q=#{encoded_query}&language=ru&apiKey=#{API_KEY}")
    response = Net::HTTP.get(url)
    JSON.parse(response)['articles'].first(3)
  end

  def self.fetch_covid_news
    query = 'COVID'
    encoded_query = CGI.escape(query)
    url = URI("https://newsapi.org/v2/everything?q=#{encoded_query}&language=ru&apiKey=#{API_KEY}")
    response = Net::HTTP.get(url)
    JSON.parse(response)['articles'].first(3)
  end
end
