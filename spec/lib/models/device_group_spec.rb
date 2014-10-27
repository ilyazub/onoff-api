RSpec.describe OnOff::API::Models::DeviceGroup do
  subject { OnOff::API::Models::DeviceGroup }

  it { is_expected.to validate_presence_of(:id) }
  it { is_expected.to validate_uniqueness_of(:id) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title) }

  it { is_expected.to have_many(:devices) }
end