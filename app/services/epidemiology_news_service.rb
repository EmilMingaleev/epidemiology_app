require 'net/http'
require 'json'
require 'uri'
require 'cgi'
require 'fileutils'

class EpidemiologyNewsService
  API_KEY      = '0cdb1b3635cf4784a4ce82018ed1056a'
  CACHE_TTL    = 10 * 60
  CACHE_DIR    = Rails.root.join('tmp', 'news_cache')
  TOPICS       = {
    epidemiology: 'эпидемиология',
    hiv: 'ВИЧ',
    covid: 'COVID'
  }

  class << self
    def fetch_all
      ensure_cache_dir!
      if cache_stale?
        data = fetch_from_api
        write_cache(data)
        data
      else
        read_cache
      end
    end

    private

    def fetch_from_api
      threads = TOPICS.map do |key, query|
        Thread.new { [key, fetch_for(query)] }
      end

      threads.each_with_object({}) do |thr, h|
        key, articles = thr.value
        h[key] = articles
      end
    end

    def fetch_for(query)
      url = URI("https://newsapi.org/v2/everything?q=#{CGI.escape(query)}&language=ru&apiKey=#{API_KEY}")
      http = Net::HTTP.start(url.host, url.port, use_ssl: true, read_timeout: 3, open_timeout: 2)
      resp = http.get(url.request_uri)
      JSON.parse(resp.body)['articles'].first(3)
    rescue StandardError => e
      Rails.logger.error "[NewsAPI] #{query!}: #{e.message}"
      []
    end

    def cache_file
      CACHE_DIR.join('all_topics.json')
    end

    def ensure_cache_dir!
      FileUtils.mkdir_p(CACHE_DIR) unless Dir.exist?(CACHE_DIR)
    end

    def cache_stale?
      return true unless File.exist?(cache_file)

      Time.now.to_i - File.mtime(cache_file).to_i > CACHE_TTL
    end

    def write_cache(data)
      File.write(cache_file, data.to_json)
    end

    def read_cache
      JSON.parse(File.read(cache_file)).transform_keys(&:to_sym)
    end
  end
end
