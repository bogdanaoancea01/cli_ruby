# frozen_string_literal: true

require './lib/options/sort_option'

RSpec.describe SortOption do
  describe '#execute' do
    let(:option) { described_class.new }
    let(:gems) do
      [
        { 'name' => 'cucumber', 'info' => 'BDD tool', 'downloads' => nil },
        { 'name' => 'cucumber-core', 'info' => 'Core library', 'downloads' => 5 },
        { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'downloads' => 500 },
        { 'name' => 'cucumber-cucumber-expressions', 'info' => 'Cucumber Expressions', 'downloads' => 0 },
        { 'name' => 'cucumber-cucumber-expressions-2', 'info' => 'Cucumber Expressions-2', 'downloads' => 20000 }
      ]
    end

    it 'orders gems based on the number of downloads - descending' do
        result = option.execute(gems)

        expect(result).to eq(
          [
            { 'name' => 'cucumber-cucumber-expressions-2', 'info' => 'Cucumber Expressions-2', 'downloads' => 20000 },
            { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'downloads' => 500 },
            { 'name' => 'cucumber-core', 'info' => 'Core library', 'downloads' => 5 },
            { 'name' => 'cucumber-cucumber-expressions', 'info' => 'Cucumber Expressions', 'downloads' => 0 },
            { 'name' => 'cucumber', 'info' => 'BDD tool', 'downloads' => nil }
          ]
        )
    end
end
end