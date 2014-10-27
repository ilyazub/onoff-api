RSpec.describe OnOff::API::Entities::DeviceGroup do
  subject { OnOff::API::Entities::DeviceGroup }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:title) }
end