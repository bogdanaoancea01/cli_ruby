# frozen_string_literal: true

require './lib/options/sort_and_filter'

RSpec.describe SortAndFilter do
  describe '#execute' do
    let(:option) { described_class.new }
    let(:licence) { 'MIT'}
    let(:gems) do
      [
        { 'name' => 'cucumber', 'info' => 'BDD tool', 'licenses' => ['Apache-2.0'], 'downloads' => nil },
        { 'name' => 'cucumber-core', 'info' => 'Core library', 'licenses' => ['Apache-2.0'], 'downloads' => 5 },
        { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'licenses' => ['MIT'], 'downloads' => 500 },
        { 'name' => 'cucumber-cucumber-expressions', 'info' => 'Cucumber Expressions', 'licenses' => ['MIT'], 'downloads' => 0 },
        { 'name' => 'cucumber-cucumber-expressions-2', 'info' => 'Cucumber Expressions-2', 'licenses' => ['MIT'], 'downloads' => 20000 }
      ]
    end

    it 'orders gems with given licence based on the number of downloads - descending' do
        result = option.execute(gems, licence)

        expect(result).to eq(
          [
            { 'name' => 'cucumber-cucumber-expressions-2', 'info' => 'Cucumber Expressions-2', 'licenses' => ['MIT'], 'downloads' => 20000 },
            { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'licenses' => ['MIT'], 'downloads' => 500 },
            { 'name' => 'cucumber-cucumber-expressions', 'info' => 'Cucumber Expressions', 'licenses' => ['MIT'], 'downloads' => 0 }
          ]
        )
    end
end
end