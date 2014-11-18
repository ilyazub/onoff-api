RSpec.describe OnOff::API::CartItems do
  let(:cart) { FactoryGirl.create(:cart) }

  describe 'POST /carts/:cart_id/cart_items' do
    let(:cart_item)         { OnOff::API::Models::Cart.first }
    let(:cart_item_entity)  { OnOff::API::Entities::CartItem.represent(cart_item).to_json }

    context 'when device id and amount presented' do
      let(:device)        { FactoryGirl.create(:device) }
      let(:new_cart_item) { FactoryGirl.build(:cart_item, cart: nil) }

      it 'creates a new cart item' do
        expect { post "/carts/#{cart.id}/cart_items", new_cart_item.to_json }.to change(OnOff::API::Models::CartItem, :count).by(1)
        expect(last_response.body).to eq cart_item_entity
      end
    end
  end

  describe 'PUT /carts/:cart_id/cart_items/:id' do
  end

  describe 'DELETE /carts/:cart_id/cart_items/:id' do
  end
end