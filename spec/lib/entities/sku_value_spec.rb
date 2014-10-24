RSpec.describe OnOff::API::Entities::SKUValue do
  subject { OnOff::API::Entities::SKUValue }

  it { is_expected.to represent(:value_id).as(:valueId) }
  it { is_expected.to represent(:unit_price).as(:unitPrice) }
end