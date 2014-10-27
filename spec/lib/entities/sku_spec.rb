RSpec.describe OnOff::API::Entities::SKU do
  subject { OnOff::API::Entities::SKU }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:title) }
  it { is_expected.to represent(:unit_price).as(:unitPrice) }
end