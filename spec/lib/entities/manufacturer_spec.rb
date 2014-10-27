RSpec.describe OnOff::API::Entities::Manufacturer do
  subject { OnOff::API::Entities::Manufacturer }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:title) }
  it { is_expected.to represent(:country) }
  it { is_expected.to represent(:assembly) }
end