RSpec.describe OnOff::API::Entities::SelectedValue do
  subject { OnOff::API::Entities::SelectedValue }

  it { is_expected.to represent(:stringified_cart_id).as(:cartId) }
  it { is_expected.to represent(:parameter_id).as(:parameterId) }

  it { is_expected.to represent(:value_id).as(:valueId) }
end