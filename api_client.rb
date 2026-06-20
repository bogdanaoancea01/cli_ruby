class APIClient
    BASE_URL = "https://rubygems.org/api/v1"
    def self.show(gem_name)
        response = Faraday.get("#{BASE_URL}/gems/#{gem_name}.json")
        if response.status == 404
            puts "Gem not found"
            exit 404
        end
        JSON.parse(response.body)
    end
end