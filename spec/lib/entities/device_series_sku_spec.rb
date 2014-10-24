RSpec.describe OnOff::API::Entities::DeviceSeriesSKU do
  subject { OnOff::API::Entities::DeviceSeriesSKU }

  let(:sku) { OpenStruct.new(title: 'BX-1254', unit_price: rand(1..100.0)) }
  let(:device_series_sku) { OpenStruct.new(sku: sku) }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:amount) }
  it { is_expected.to represent(:layer) }

  it { is_expected.to represent(:title).exposes_at_runtime(device_series_sku, device_series_sku.sku.title) }
  it { is_expected.to represent(:unit_price).as(:unitPrice).exposes_at_runtime(device_series_sku, device_series_sku.sku.unit_price) }
  it { is_expected.to represent(:parameters).using(OnOff::API::Entities::SKUParameter) }
end