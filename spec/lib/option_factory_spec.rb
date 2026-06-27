# frozen_string_literal: true

require './lib/options/option_factory'
require './lib/options/licence_option'
require './lib/options/sort_option'
require './lib/options/sort_and_filter'

RSpec.describe OptionFactory do
  describe '#find' do
    it 'returns a SortOption for sort' do
      option = described_class.find('sort')

      expect(option).to be_a(SortOption)
    end

    it 'returns a LicenceCommand for licence' do
      option = described_class.find('licence')

      expect(option).to be_a(LicenceOption)
    end

    it 'returns a SortAndFilter for sort-and-filter' do
      option = described_class.find('sort-and-filter')

      expect(option).to be_a(SortAndFilter)
    end

    it 'returns nil for an unknown option' do
      option = described_class.find('--unknown')

      expect(option).to be_nil
    end
  end
end
