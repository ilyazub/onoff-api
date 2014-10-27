RSpec.describe OnOff::API::Entities::Series do
  subject { OnOff::API::Entities::Series }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:title) }
  it { is_expected.to represent(:manufacturer).using(OnOff::API::Entities::Manufacturer) }
end