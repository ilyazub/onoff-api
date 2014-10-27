RSpec.describe OnOff::API::Entities::DeviceSeries do
  subject { OnOff::API::Entities::DeviceSeries }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:series).using(OnOff::API::Entities::Series) }
  it { is_expected.to represent(:device_series_skus).as(:deviceSeriesSkus).using(OnOff::API::Entities::DeviceSeriesSKU) }
end