# frozen_string_literal: true

require './lib/commands/command_factory'
require './lib/commands/show_command'
require './lib/commands/search_command'

RSpec.describe CommandFactory do
  describe '#find' do
    it 'returns a ShowCommand for show' do
      command = described_class.find('show')

      expect(command).to be_a(ShowCommand)
    end

    it 'returns a SearchCommand for search' do
      command = described_class.find('search')

      expect(command).to be_a(SearchCommand)
    end

    it 'returns nil for an unknown command' do
      command = described_class.find('unknown')

      expect(command).to be_nil
    end
  end
end
