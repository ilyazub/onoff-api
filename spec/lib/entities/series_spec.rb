RSpec.describe OnOff::API::Entities::Series do
  subject { OnOff::API::Entities::Series }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:title) }

  it { is_expected.to represent(:manufacturer).using(OnOff::API::Entities::Manufacturer) }
  it { is_expected.to represent(:devices_parameters).as(:parameters).using(OnOff::API::Entities::Parameter) }
  it { is_expected.to represent(:device_series_skus).as(:skus).using(OnOff::API::Entities::DeviceSeriesSKU) }
end