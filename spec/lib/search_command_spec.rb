# frozen_string_literal: true

require './lib/commands/search_command'

RSpec.describe SearchCommand do
  describe '#execute' do
    let(:client) { double('APIClient') }
    let(:command) { described_class.new(client) }

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

    context 'search command with sort options' do
      let(:args_with_sort) { ['cucumber', '--most-downloads-first'] }
      let(:api_response_sort) do
        [
          { 'name' => 'cucumber', 'info' => 'BDD tool', 'downloads' => nil },
          { 'name' => 'cucumber-core', 'info' => 'Core library', 'downloads' => 5 },
          { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'downloads' => 500 },
          { 'name' => 'cucumber-cucumber-expressions', 'info' => 'Cucumber Expressions', 'downloads' => 0 },
          { 'name' => 'cucumber-cucumber-expressions-2', 'info' => 'Cucumber Expressions-2', 'downloads' => 20_000 }
        ]
      end
      let(:gems_after_sort) do
        "cucumber-cucumber-expressions-2\ncucumber-rails\ncucumber-core\ncucumber-cucumber-expressions\ncucumber"
      end

      it 'returns a sorted array of gems based on the number of downloads - descending' do
        allow(client)
          .to receive(:search)
          .with(args_with_sort.first)
          .and_return(api_response_sort)

        result = command.execute(args_with_sort)

        expect(result.exit_code).to eq(0)
        expect(result.exit_description).to eq(gems_after_sort)
      end
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

    context 'search command with sort and licence options' do
      let(:args_with_sort_and_licence) { ['cucumber', '--most-downloads-first', '--licence', 'MIT'] }
      let(:api_response_sort_and_licence) do
        [
          { 'name' => 'cucumber', 'info' => 'BDD tool', 'licenses' => ['Apache-2.0'], 'downloads' => nil },
          { 'name' => 'cucumber-core', 'info' => 'Core library', 'licenses' => ['MIT'], 'downloads' => 5 },
          { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'licenses' => ['MIT'], 'downloads' => 500 },
          { 'name' => 'cucumber-cucumber-expressions', 'info' => 'Cucumber Expressions', 'licenses' => ['GPL-3.0'],
            'downloads' => 0 },
          { 'name' => 'cucumber-cucumber-expressions-2', 'info' => 'Cucumber Expressions-2', 'licenses' => ['MIT'],
            'downloads' => 20_000 }
        ]
      end
      let(:gems_after_sort_and_licence) do
        "cucumber-cucumber-expressions-2\ncucumber-rails\ncucumber-core"
      end

      it 'returns a sorted array of gems containing specified licence based on the number of downloads - descending' do
        allow(client)
          .to receive(:search)
          .with(args_with_sort_and_licence.first)
          .and_return(api_response_sort_and_licence)

        result = command.execute(args_with_sort_and_licence)

        expect(result.exit_code).to eq(0)
        expect(result.exit_description).to eq(gems_after_sort_and_licence)
      end
    end
  end
end
