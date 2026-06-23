# frozen_string_literal: true

require './lib/commands/command_factory'
require './lib/commands/show_command'

RSpec.describe CommandFactory do
  describe '.find' do
    it 'returns a ShowCommand for show' do
      command = CommandFactory.find('show')

      expect(command).to be_a(ShowCommand)
    end

    it 'returns nil for an unknown command' do
      command = CommandFactory.find('unknown')

      expect(command).to be_nil
    end
  end
end
