RSpec.describe OnOff::API::Entities::Parameter do
  subject { OnOff::API::Entities::Parameter }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:variable) }
  it { is_expected.to represent(:description) }

  it { is_expected.to represent(:values).using(OnOff::API::Entities::Value) }
end