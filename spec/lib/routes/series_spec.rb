RSpec.describe OnOff::API::Series do
  let(:cart)            { OnOff::API::Models::Cart.create }
  let(:series_entities) { OnOff::API::Entities::Series.represent(cart.series).to_json }

  def prepare_db
    device_group = OnOff::API::Models::DeviceGroup.create(title: 'Рамка')
    device_group.devices.create(title: 'Рамка 1-ая')

    cart.devices << device_group.devices.first
    cart.save

    manufacturer = OnOff::API::Models::Manufacturer.create(assembly: 'Busch Jaeger', title: 'ABB', country: 'Германия')
    manufacturer.series.create(title: 'Axcent')

    device_series = OnOff::API::Models::DeviceSeries.create(device: cart.devices.first, series: manufacturer.series.first)
  end

  describe "GET /carts/:cart_id/series" do
    let(:cart_id) { cart.id.to_s }

    before do
      prepare_db
    end

    it 'gets all series in current cart' do
      get "/carts/#{cart_id}/series"

      expect(last_response.body).to eq series_entities
    end
  end
end