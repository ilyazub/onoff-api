RSpec.describe OnOff::API::Entities::Value do
  subject { OnOff::API::Entities::Value }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:code) }
  it { is_expected.to represent(:description) }
  it { is_expected.to represent(:selected) }
end