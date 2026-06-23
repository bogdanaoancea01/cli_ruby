require './lib/api_client'

RSpec.describe APIClient do
    describe '#show' do 
        let(:gem_name) { "rails" }
        let(:gem_name_not_existent) { "bogdana" }

        it 'returns gem not found when gem does not exist' do
            expect(APIClient.show(gem_name_not_existent)).to eq("Gem not found")
        end
    end
end