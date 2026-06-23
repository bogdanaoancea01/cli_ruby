require "faraday"
class APIClient
    BASE_URL = "https://rubygems.org/api/v1"
    def self.show(gem_name)
        response = Faraday.get("#{BASE_URL}/gems/#{gem_name}.json")
        if response.status == 404
            return "Gem not found"
        end
        JSON.parse(response.body)
    end
end