# frozen_string_literal: true

require './lib/options/sort_option'
require './lib/options/parse_options'

RSpec.describe ParseOptions do
  describe '#execute' do

    let(:args) { ['--licence', 'LICENCE', '--most-downloads-first'] }

    context 'when no arguments are given' do
      let(:args) { [] }

      it 'returns the default options' do
        options = described_class.execute(args)

        expect(options.licence).to be_nil
        expect(options.sort).to be(false)
      end
    end

    context 'when no arguments are given' do
      it 'returns the parsed options' do
        options = described_class.execute(args)

        expect(options.licence).to eq('LICENCE')
        expect(options.sort).to be(true)
      end
    end
  end
end