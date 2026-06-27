# frozen_string_literal: true

require './lib/commands/search_command'

RSpec.describe SearchCommand do
  describe '#execute' do
    let(:client) { double('APIClient') }
    let(:command) { SearchCommand.new(client) }

    let(:args_with_good_keyword) { ['cucumber'] }
    let(:args_with_bad_keyword) { ['bogdana'] }
    let(:gems_list) do
      "cucumber\ncucumber-core\ncucumber-rails\nallure-cucumber\ncucumber-api"
    end
    let(:api_response) do
      [
        { 'name' => 'cucumber', 'info' => 'BDD tool' },
        { 'name' => 'cucumber-core', 'info' => 'Core library' },
        { 'name' => 'cucumber-rails', 'info' => 'Rails integration' },
        { 'name' => 'allure-cucumber', 'info' => 'Cucumber adaptor to generate rich allure test reports' },
        { 'name' => 'cucumber-api',
          'info' => 'cucumber-api allows API JSON response validation and verification in BDD style.' }
      ]
    end

    let(:args_with_licence) { ['cucumber', '--licence', 'MIT'] }
    let(:gems_list_with_licence_mit) do
      "cucumber\ncucumber-core\ncucumber-rails"
    end
    let(:api_response_licence) do
      [
        { 'name' => 'cucumber', 'info' => 'BDD tool', 'licenses' => ['MIT'] },
        { 'name' => 'cucumber-core', 'info' => 'Core library', 'licenses' => ['MIT'] },
        { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'licenses' => ['MIT'] }
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
        .with(args_with_bad_keyword.first)
        .and_return([])

      result = command.execute(args_with_bad_keyword)

      expect(result.exit_code).to eq(4)
      expect(result.exit_description).to eq('No gems found')
    end

    it 'returns a list of gems that contain the given keyword' do
      allow(client)
        .to receive(:search)
        .with(args_with_good_keyword.first)
        .and_return(api_response)

      result = command.execute(args_with_good_keyword)

      expect(result.exit_code).to eq(0)
      expect(result.exit_description).to eq(gems_list)
    end

    context 'search command with licence options' do
      it 'returns matching gems that have the specified licence' do
        allow(client)
          .to receive(:search)
          .with(args_with_licence.first)
          .and_return(api_response_licence)

        result = command.execute(args_with_licence)

        expect(result.exit_code).to eq(0)
        expect(result.exit_description).to eq(gems_list_with_licence_mit)
      end
    end
  end
end
