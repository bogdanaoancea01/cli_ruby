# frozen_string_literal: true

require './lib/options/sort_option'
require './lib/options/parse_options'

RSpec.describe ParseOptions do
  describe '#execute' do
    context 'when no arguments are given' do
      let(:args) { [] }
      let(:result) { [] }

      it 'returns an empty array' do
        options = described_class.execute(args)

        expect(options).to eq(result)
      end
    end

    context 'when both options are given' do
      let(:args) { ['--licence', 'LICENCE', '--most-downloads-first'] }

      it 'returns an array containing the options objects' do
        options = described_class.execute(args)

        expect(options[0]).to be_a(LicenceOption)
        expect(options[1]).to be_a(SortOption)
      end
    end
  end
end