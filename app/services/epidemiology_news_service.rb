require 'net/http'
require 'json'
require 'uri'
require 'cgi'

class EpidemiologyNewsService
  API_KEY = '0cdb1b3635cf4784a4ce82018ed1056a'

  def self.fetch_news(query)
    encoded_query = CGI.escape(query)
    url = URI("https://newsapi.org/v2/everything?q=#{encoded_query}&language=ru&domains=rbc.ru,ria.ru,kommersant.ru,tass.ru,lenta.ru,rg.ru,iz.ru,vedomosti.ru&apiKey=#{API_KEY}")
    response = Net::HTTP.get(url)
    JSON.parse(response)['articles'].first(3)
  end

  def self.fetch_all_news
    queries = {
      epidemiology: 'эпидемиология',
      hiv: 'ВИЧ',
      covid: 'COVID'
    }

    results = {}
    threads = []

    queries.each do |key, query|
      threads << Thread.new do
        results[key] = fetch_news(query)
      end
    end

    threads.each(&:join)
    results
  end
end
