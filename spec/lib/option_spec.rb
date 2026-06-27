# frozen_string_literal: true

require './lib/options/option'

RSpec.describe Option do
  describe '#execute' do
    it 'raises NotImplementedError' do
      expect do
        Option.new.execute([])
      end.to raise_error(NotImplementedError)
    end
  end
end
