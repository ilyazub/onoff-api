RSpec.describe OnOff::API::Entities::DeviceSeriesSKU do
  subject { OnOff::API::Entities::DeviceSeriesSKU }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:amount) }
  it { is_expected.to represent(:layer) }

  it { is_expected.to represent(:sku).using(OnOff::API::Entities::SKU) }

  it { is_expected.to represent(:parameters).using(OnOff::API::Entities::Parameter) }
end