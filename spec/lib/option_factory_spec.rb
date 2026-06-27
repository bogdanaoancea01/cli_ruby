# frozen_string_literal: true

require './lib/options/option_factory'
require './lib/options/licence_option'

RSpec.describe OptionFactory do
  describe '#find' do
    it 'returns a LicenceCommand for --licence' do
      option = OptionFactory.find('--licence')

      expect(option).to be_a(LicenceOption)
    end

    it 'returns nil for an unknown option' do
      option = OptionFactory.find('--unknown')

      expect(option).to be_nil
    end
  end
end
