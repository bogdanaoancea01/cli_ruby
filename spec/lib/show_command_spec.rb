# frozen_string_literal: true

require './lib/commands/show_command'

RSpec.describe ShowCommand do
  describe '#execute' do
    let(:command) { ShowCommand.new }
    let(:exit_description) do
      "Gem name: rails\nGem info: Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration."
    end

    it 'returns exit code 3 when no gem name is given' do
      result = command.execute(nil)

      expect(result.exit_code).to eq(3)
      expect(result.exit_description).to eq('No gem name given')
    end

    it 'returns gem not found for a gem that does not exist' do
      result = command.execute('bogdana')

      expect(result.exit_code).to eq(4)
      expect(result.exit_description).to eq('Gem not found')
    end

    it 'returns information for rails' do
      result = command.execute('rails')

      expect(result.exit_code).to eq(0)
      expect(result.exit_description).to eq(exit_description)
    end
  end
end
