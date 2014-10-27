RSpec.describe OnOff::API::CartItems do
  let(:cart) { OnOff::API::Models::CartItem.create }

  describe 'POST /carts/:cart_id/cart_items' do
    let(:created_cart_item) { OnOff::API::Entities::CartItem.represent(OnOff::API::Models::CartItem.first).to_json }

    context 'when device id and amount presented' do
      let(:device_group)  { OnOff::API::Models::Device.create(title: 'Bed') }
      let(:device)        { OnOff::API::Models::Device.create(title: 'Blanket', device_group: device_group) }
      let(:cart_item_data) { { device_id: device.id, amount: 2 } }

      it 'creates a new cart item' do
        expect { post "/carts#{cart.id}/cart_items", cart_item_data }.to change(OnOff::API::Models::CartItem, :count).by(1)
        expect(last_response.body).to eq created_cart_item
      end
    end
  end

  describe 'PUT /carts/:cart_id/cart_items/:id' do
  end

  describe 'DELETE /carts/:cart_id/cart_items/:id' do
  end
end