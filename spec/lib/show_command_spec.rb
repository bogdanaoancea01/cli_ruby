# frozen_string_literal: true

require './lib/commands/show_command'

RSpec.describe ShowCommand do
  describe '#execute' do
    let(:client) { double('APIClient') }
    let(:command) { described_class.new(client) }
    let(:exit_description) do
      "Gem name: rails\nGem info: Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration."
    end
    let(:gem_json) do
      File.read('spec/fixtures/gem_json.json')
    end
    let(:args_with_bad_gem) { ['bogdana'] }
    let(:args_with_good_gem) { ['rails'] }

    it 'returns exit code 3 when no gem name is given' do
      result = command.execute(nil)

      expect(result.exit_code).to eq(3)
      expect(result.exit_description).to eq('No gem name given')
    end

    it 'returns gem not found for a gem that does not exist' do
      allow(client)
        .to receive(:show)
        .with(args_with_bad_gem.first)
        .and_return('Gem not found')

      result = command.execute(args_with_bad_gem)

      expect(result.exit_code).to eq(4)
      expect(result.exit_description).to eq('Gem not found')
    end

    it 'returns information for rails gem' do
      allow(client)
        .to receive(:show)
        .with(args_with_good_gem.first)
        .and_return(JSON.parse(gem_json))

      result = command.execute(args_with_good_gem)

      expect(result.exit_code).to eq(0)
      expect(result.exit_description).to eq(exit_description)
    end
  end
end
