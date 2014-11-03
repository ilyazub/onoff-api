RSpec.describe OnOff::API::Entities::DeviceSeriesSKU do
  subject { OnOff::API::Entities::DeviceSeriesSKU }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:amount) }

  it { is_expected.to represent(:device_id).as(:deviceId) }
  it { is_expected.to represent(:title) }
  it { is_expected.to represent(:unit_price).as(:unitPrice) }

  it { is_expected.to represent(:sku_parameters).as(:parameters).using(OnOff::API::Entities::SKUParameter) }
end