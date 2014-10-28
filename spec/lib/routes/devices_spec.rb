RSpec.describe OnOff::API::Devices do
  describe 'GET /devices' do
    let(:entities) { OnOff::API::Entities::Device.represent(OnOff::API::Models::Device.all) }

    before do
      (0..10).each { |index| OnOff::API::Models::Device.create(title: "Device ##{index}") }
    end

    it 'presents all devices' do
      get '/devices'

      expect(last_response.body).to eq entities.to_json
    end
  end
end