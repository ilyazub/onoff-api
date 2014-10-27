RSpec.describe OnOff::API::Models::Series do
  subject { OnOff::API::Models::Series }

  it { is_expected.to validate_presence_of(:id) }
  it { is_expected.to validate_uniqueness_of(:id) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title) }

  it { is_expected.to belong_to(:manufacturer) }

  it { is_expected.to have_many(:device_series) }
  it { is_expected.to have_many(:devices) }
  it { is_expected.to have_many(:device_series_skus) }
  it { is_expected.to have_many(:taggings) }
end