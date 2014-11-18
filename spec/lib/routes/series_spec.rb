RSpec.describe OnOff::API::Series do
  let(:cart)            { FactoryGirl.create(:cart) }
  let(:device)          { FactoryGirl.create(:device) }
  let(:series)          { FactoryGirl.create(:series) }
  let(:device_series)   { FactoryGirl.create_list(:device_series, 4, device: device, series: series) }
  let(:series_entities) { OnOff::API::Entities::Series.represent([series]).to_json }

  before do
    device_series
    FactoryGirl.create_list(:cart_item, 4, cart: cart, device: device)
  end

  it 'requires cart id as a UUID string' do
    get "/carts/invalid-cart-id-1/series"

    expect(last_response.status).to eq 500
    expect(last_response.body).to include 'Invalid UUID format.'
  end

  describe 'GET /carts/:cart_id/series' do
    it 'gets all series in current cart' do
      get "/carts/#{cart.id}/series"

      expect(last_response.body).to eq series_entities
    end
  end

  describe 'Certain series' do
    let(:series) { FactoryGirl.create(:series) }

    before do
      FactoryGirl.create_list(:device_series_sku, 4, device_series: device_series.first)
    end

    describe 'GET /carts/:cart_id/series/:series_id.xml' do
      it 'requires series id as an Integer' do
        get "/carts/#{cart.id}/series/list.xml"

        expect(last_response.status).to eq 400
        expect(last_response.body).to include "series_id is invalid"
      end

      it 'sends attachment as XML' do
        get "/carts/#{cart.id}/series/#{series.id}.xml"

        expect(last_response.headers['Content-Type']).to eq "application/xml; charset=UTF-8"
        expect(last_response.headers['Content-Disposition']).to eq "attachment; filename*=UTF-8''#{URI.escape(series.title)}.xml"
      end
    end

    describe 'PUT /carts/:cart_id/series/:series_id/values' do
      before do
        FactoryGirl.create_list(:sku_value, 10)
      end

      it 'requires parameters id, value id and selected flag' do
        fail
      end

      it 'gets or creates selected value' do
        fail
      end
    end
  end
end