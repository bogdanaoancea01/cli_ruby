require './lib/api_client'

RSpec.describe APIClient do
    describe '#show' do 
        let(:gem_name) { "rails" }
        let(:gem_name_not_existent) { "bogdana" }

        it 'returns json object' do
            expect { APIClient.show(gem_name_not_existent) }.to output(/Gem not found/).to_stdout
        end
    end
end