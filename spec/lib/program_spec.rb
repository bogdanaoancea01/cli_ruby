# frozen_string_literal: true

require './lib/program'

RSpec.describe Program do
  describe '#execute' do
    let(:args) { %w[show rails] }
    let(:args_no_command) { [] }
    let(:args_bad_command) { %w[see rails] }
    let(:args_no_gem) { ['show'] }

    it 'returns 0 exit code' do
      command = double

      allow(CommandFactory)
        .to receive(:find)
        .with('show')
        .and_return(command)

      allow(command)
        .to receive(:execute)
        .with(['rails'])
        .and_return(
          ProgramResult.new(
            0,
            "Gem name: rails\nGem info: Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration."
          )
        )

      result = Program.new.execute(%w[show rails])

      expect(result.exit_code).to eq(0)
    end

    it 'returns 1 exit code' do
      result = Program.new.execute(args_no_command)

      expect(result.exit_code).to eq(1)
      expect(result.exit_description).to eq('No command given')
    end

    it 'returns 2 exit code' do
      result = Program.new.execute(args_bad_command)

      expect(result.exit_code).to eq(2)
      expect(result.exit_description).to eq('Command unknown')
    end

    it 'returns 3 exit code' do
      result = Program.new.execute(args_no_gem)

      expect(result.exit_code).to eq(3)
      expect(result.exit_description).to eq('No gem name given')
    end
  end
end
