RSpec.describe OnOff::API::Carts do
  describe 'CORS' do
    it 'should support OPTIONS CORS request' do
      fail 'Check CORS after main specs'

      cors_request '/carts', method: :options
    end
  end

  describe 'POST /carts' do
    let(:created_cart) { OnOff::API::Entities::Cart.represent(OnOff::API::Models::Cart.first).to_json }

    it 'creates a new cart' do
      expect { post '/carts' }.to change(OnOff::API::Models::Cart, :count).by(1)
      expect(last_response.body).to eq created_cart
    end
  end

  describe 'PUT /carts' do
    let(:cart_entity) { OnOff::API::Entities::Cart.represent(cart).to_json }

    context 'when cart exists' do
      let(:cart) { OnOff::API::Models::Cart.create }

      it 'updates a cart' do
        put "/carts/#{cart.id}", cart.to_json
        expect(cart.updated_at).to be > cart.created_at
        expect(last_response.body).to eq cart_entity
      end
    end

    context 'when cart is not exist' do
      let(:cart) { OnOff::API::Models::Cart.new }

      it 'creates a new cart' do
        put "/carts/#{cart.id}", cart.to_json
        expect(last_response.body).not_to eq cart_entity
      end
    end
  end
end