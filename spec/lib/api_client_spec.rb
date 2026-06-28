# frozen_string_literal: true

require './lib/api_client'

RSpec.describe APIClient do
  describe '#show' do
    let(:gem_json) do
      File.read('spec/fixtures/gem_json.json')
    end
    let(:non_existent_gem) { 'bogdana' }
    let(:gem) { 'rails' }

    context 'when gem exists' do
      it 'returns gem information about the provided gem' do
        fake_response = double('Faraday::Response', status: 200, body: gem_json)
        allow(APIClient::CONNECTION).to receive(:get)
          .with("#{APIClient::BASE_URL}/gems/#{gem}.json")
          .and_return(fake_response)

        result = APIClient.show(gem)

        expect(result['name']).to eq('rails')
        expect(result['info']).to eq('Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration.')
      end
    end

    context 'when gem does not exist' do
      it 'returns a not found message' do
        allow(APIClient::CONNECTION).to receive(:get)
          .with("#{APIClient::BASE_URL}/gems/#{non_existent_gem}.json")
          .and_raise(Faraday::ResourceNotFound)
        result = APIClient.show(non_existent_gem)

        expect(result).to eq('Gem not found')
      end
    end

    context 'when server error occurs occur' do
      it 'returns a \'See status codes for more details\' message' do
        allow(APIClient::CONNECTION).to receive(:get)
          .with("#{APIClient::BASE_URL}/gems/#{non_existent_gem}.json")
          .and_raise(Faraday::ServerError)
        result = APIClient.show(non_existent_gem)

        expect(result).to eq('See status codes for more details')
      end
    end
  end

  describe '#search' do
    let(:search_api_response) do
      double(
        'Faraday::Response',
        status: 200,
        body: [
          { name: 'cucumber', info: 'BDD tool' },
          { name: 'cucumber-core', info: 'Core library' },
          { name: 'cucumber-rails', info: 'Rails integration' }
        ].to_json
      )
    end
    let(:bad_keyword) { 'bogdana' }
    let(:good_keyword) { 'cucumber' }

    context 'when there are no gems with the given keyword' do
      it 'returns no gems found message' do
        allow(APIClient::CONNECTION).to receive(:get)
          .with("#{APIClient::BASE_URL}/search.json?query=#{bad_keyword}")
          .and_raise(Faraday::ResourceNotFound)

        result = APIClient.search(bad_keyword)

        expect(result).to eq('No gems found')
      end
    end

    context 'when gems exist' do
      it 'returns a list of gems that contain the given keyword' do
        allow(APIClient::CONNECTION).to receive(:get)
          .with("#{APIClient::BASE_URL}/search.json?query=#{good_keyword}")
          .and_return(search_api_response)

        result = APIClient.search(good_keyword)

        expect(result).to eq(
          [
            { 'name' => 'cucumber', 'info' => 'BDD tool' },
            { 'name' => 'cucumber-core', 'info' => 'Core library' },
            { 'name' => 'cucumber-rails', 'info' => 'Rails integration' }
          ]
        )
      end
    end

    context 'when server error occurs occur' do
      it 'returns a \'See status codes for more details\' message' do
        allow(APIClient::CONNECTION).to receive(:get)
          .with("#{APIClient::BASE_URL}/search.json?query=#{good_keyword}")
          .and_raise(Faraday::TimeoutError)

        result = APIClient.search(good_keyword)

        expect(result).to eq('See status codes for more details')
      end
    end
  end
end
