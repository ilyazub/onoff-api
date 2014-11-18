RSpec.describe OnOff::API::Carts do
  describe 'POST /carts' do
    let(:cart_entity) { OnOff::API::Entities::Cart.represent(OnOff::API::Models::Cart.first).to_json }

    it 'creates a new cart' do
      expect { post '/carts' }.to change(OnOff::API::Models::Cart, :count).by(1)
      expect(last_response.body).to eq cart_entity
    end
  end

  describe 'PUT /carts' do
    let(:cart_entity) { OnOff::API::Entities::Cart.represent(cart).to_json }

    context 'when cart exists' do
      let(:cart) { FactoryGirl.create(:cart) }

      it 'updates a cart' do
        put "/carts/#{cart.id}", cart.to_json
        expect(cart.reload.updated_at).to be > cart.created_at
        expect(last_response.body).to eq cart_entity
      end
    end

    context 'when cart is not exist' do
      let(:cart) { FactoryGirl.build(:cart) }

      it 'creates a new cart' do
        expect { put "/carts/#{cart.id}", cart.to_json }.to change(OnOff::API::Models::Cart, :count).by(1)
        expect(last_response.body).not_to eq cart_entity
      end
    end
  end
end