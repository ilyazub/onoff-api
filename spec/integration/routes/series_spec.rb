RSpec.describe OnOff::API::Series do
  let(:cart)    { OnOff::API::Models::Cart.create }
  let(:cart_id) { cart.id }
  let(:series) { OnOff::API::Entities::Series.represent(cart.series).to_json }

  def prepare_db
    device_group = OnOff::API::Models::DeviceGroup.create(title: 'Рамка')
    device = device_group.devices.create(title: 'Рамка 1-ая')

    cart.devices << device
    cart.save

    manufacturer = OnOff::API::Models::Manufacturer.create(assembly: 'Busch Jaeger', title: 'ABB', country: 'Германия')
    serie = OnOff::API::Models::Series.create(title: 'Axcent')

    device_series = OnOff::API::Models::DeviceSeries.create(device: device, manufacturer: manufacturer, series: serie)
  end

  describe "GET /carts/:cart_id/series" do
    before do
      prepare_db
    end

    it 'gets all devices in current cart' do
      get "/carts/#{cart_id}/series"

      expect(last_response.body).to eq series
    end
  end
end