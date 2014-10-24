RSpec.describe OnOff::API::Entities::DeviceGroup do
  subject { OnOff::API::Entities::DeviceGroup }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:title) }
  it { is_expected.to represent(:parameters).using(OnOff::API::Entities::Parameter) }
  it { is_expected.to represent(:device_series_skus).as(:skus).using(OnOff::API::Entities::DeviceSeriesSKU) }
end