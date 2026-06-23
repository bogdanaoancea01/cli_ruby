require './lib/commands/command'

RSpec.describe Command do
  describe '#execute' do
    it 'raises NotImplementedError' do
        expect {
            Command.new.execute([])
        }.to raise_error(NotImplementedError)
    end
  end
end