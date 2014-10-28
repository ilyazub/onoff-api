RSpec.describe OnOff::API::Entities::SelectedValue do
  subject { OnOff::API::Entities::SelectedValue }

  it { is_expected.to represent(:value_id) }

  it { is_expected.to represent(:cart_id) }
  it { is_expected.to represent(:series_id) }
end