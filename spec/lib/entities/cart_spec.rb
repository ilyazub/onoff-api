RSpec.describe OnOff::API::Entities::Cart do
  subject { OnOff::API::Entities::Cart }

  let(:cart) { OpenStruct.new(id: UUIDTools::UUID.random_create) }

  it { is_expected.to represent(:id).runtime_exposure(cart, cart.id.to_s) }
  it { is_expected.to represent(:cart_items).as(:cartItems).using(OnOff::API::Entities::CartItem) }
end