# frozen_string_literal: true

require './lib/commands/search_command'

RSpec.describe ShowCommand do
  describe '#execute' do
    let(:client) { double('APIClient') }
    let(:command) { SearchCommand.new(client) }
    let(:keyword) { 'cucumber' }
    let(:bad_keyword) { 'bogdana' }
    let(:gems_list) do
      "cucumber\ncucumber-core\ncucumber-rails"
    end
    let(:api_response) do
      [
        { 'name' => 'cucumber', 'info' => 'BDD tool' },
        { 'name' => 'cucumber-core', 'info' => 'Core library' },
        { 'name' => 'cucumber-rails', 'info' => 'Rails integration' }
      ]
    end

    it 'returns exit code 3 when no keyword is given' do
      result = command.execute(nil)

      expect(result.exit_code).to eq(3)
      expect(result.exit_description).to eq('No keyword given')
    end

    it 'returns no gems found when no gem contains the given keyword' do
      allow(client)
        .to receive(:search)
        .with(bad_keyword)
        .and_return([])

      result = command.execute(bad_keyword)

      expect(result.exit_code).to eq(4)
      expect(result.exit_description).to eq('No gems found')
    end

    it 'returns a list of gems that contain the given keyword' do
      allow(client)
        .to receive(:search)
        .with(keyword)
        .and_return(api_response)

      result = command.execute(keyword)

      expect(result.exit_code).to eq(0)
      expect(result.exit_description).to eq(gems_list)
    end
  end
end
