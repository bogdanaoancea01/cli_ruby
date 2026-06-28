# frozen_string_literal: true

require './lib/options/licence_option'

RSpec.describe LicenceOption do
  describe '#execute' do
    

    let(:gems) do
      [
        { 'name' => 'cucumber', 'info' => 'BDD tool', 'licenses' => ['MIT'] },
        { 'name' => 'cucumber-core', 'info' => 'Core library', 'licenses' => ['Apache-2.0'] },
        { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'licenses' => ['MIT', 'GPL-3.0'] },
        { 'name' => 'cucumber-rspec', 'info' => 'RSpec integration', 'licenses' => nil }
      ]
    end

    context 'when gems match the licence' do
      let(:option) { described_class.new('MIT') }
      it 'returns only gems with the specified licence' do
        result = option.execute(gems)

        expect(result).to eq(
          [
            { 'name' => 'cucumber', 'info' => 'BDD tool', 'licenses' => ['MIT'] },
            { 'name' => 'cucumber-rails', 'info' => 'Rails integration', 'licenses' => ['MIT', 'GPL-3.0'] }
          ]
        )
      end
    end

    context 'when no gems match the licence' do
      let(:option) { described_class.new('GPL-2.0') }
      it 'returns an empty array when no gems contain the given licence' do
        result = option.execute(gems)

        expect(result).to eq([])
      end
    end

    context 'when no licence name is given' do
      let(:option) { described_class.new(nil) }
      it 'returns an empty array when no given licence' do
        result = option.execute(gems)

        expect(result).to eq([])
      end
    end
  end
end
