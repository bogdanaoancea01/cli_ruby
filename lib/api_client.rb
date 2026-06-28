# frozen_string_literal: true

require 'faraday'
class APIClient
  BASE_URL = 'https://rubygems.org/api/v1'
  CONNECTION = Faraday.new do |config|
    config.response :raise_error
  end

  def self.show(gem_name)
    response = CONNECTION.get("#{BASE_URL}/gems/#{gem_name}.json")

    JSON.parse(response.body)
  rescue Faraday::ResourceNotFound
    'Gem not found'
  rescue Faraday::Error
    'See status codes for more details'
  end

  def self.search(keyword)
    response = CONNECTION.get("#{BASE_URL}/search.json?query=#{keyword}")

    JSON.parse(response.body)
  rescue Faraday::ResourceNotFound
    'No gems found'
  rescue Faraday::Error
    'See status codes for more details'
  end
end
