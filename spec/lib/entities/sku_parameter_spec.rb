RSpec.describe OnOff::API::Entities::SKUParameter do
  subject { OnOff::API::Entities::SKUParameter }

  it { is_expected.to represent(:parameter_id).as(:parameterId) }
  it { is_expected.to represent(:values).using(OnOff::API::Entities::SKUValue) }
end