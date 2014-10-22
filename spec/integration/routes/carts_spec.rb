RSpec.describe OnOff::API::Carts do
  describe 'CORS' do
    it 'should support OPTIONS CORS request' do
      fail 'Check CORS after main specs'

      cors_request '/carts', method: :options
    end
  end

  describe 'POST /carts' do
    it 'initializes a new cart' do
      post '/carts'

      hash = { id: "5d666650-5d6b-4496-845f-b6ab8617243a", cart_items: [] }
      expect(last_response.body).to eq hash.to_json
    end
  end

  describe 'PUT /carts' do
    let(:existing_cart)   { { id: "5d666650-5d6b-4496-845f-b6ab8617243a" } }
    let(:unexisting_cart) { { id: UUIDTools::UUID.random_create } }
    let(:result_json)     { { id: "5d666650-5d6b-4496-845f-b6ab8617243a", cart_items: [] } }

    it 'updates an existing cart' do
      put "/carts/#{existing_cart[:id]}", existing_cart.to_json
      expect(last_response.body).to eq result_json.to_json
    end

    it 'updates an unexisting cart' do
      put "/carts/#{unexisting_cart[:id]}", unexisting_cart.to_json
      expect(last_response.body).to eq result_json.to_json
    end
  end
end