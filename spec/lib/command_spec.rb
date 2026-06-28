# frozen_string_literal: true

require './lib/commands/command'

RSpec.describe Command do
  describe '#execute' do
    it 'raises NotImplementedError' do
      expect do
        Command.new.execute([])
      end.to raise_error(NotImplementedError)
    end
  end
end
