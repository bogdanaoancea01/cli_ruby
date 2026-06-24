# frozen_string_literal: true

require 'faraday'
class APIClient
  BASE_URL = 'https://rubygems.org/api/v1'
  def self.show(gem_name)
    response = Faraday.get("#{BASE_URL}/gems/#{gem_name}.json")
    return 'Gem not found' if response.status == 404

    JSON.parse(response.body)
  end

  def self.search(keyword)
    response = Faraday.get("#{BASE_URL}/search.json?query=#{keyword}")
    return 'No gems found' if response.status == 404

    JSON.parse(response.body)
  end
end
