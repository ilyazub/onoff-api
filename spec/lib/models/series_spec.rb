RSpec.describe OnOff::API::Models::Series do
  describe "properties" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }

    it { is_expected.to belong_to(:manufacturer) }

    it { is_expected.to have_many(:device_series) }
    it { is_expected.to have_many(:devices) }
  end

  subject       { FactoryGirl.create(:series) }
  let(:devices) { FactoryGirl.create_list(:device, 3) }

  before do
    subject.remember_devices(devices)

    @device_series = FactoryGirl.create_list(:device_series, 3, series: subject)

    devices.each do |device|
      @device_series.concat FactoryGirl.create_list(:device_series, 2, device: device, series: subject)
    end

    devices.each do |device|
      @device_series.concat FactoryGirl.create_list(:device_series, 4, device: device)
    end

    @device_series.each do |device_serie|
      FactoryGirl.create(:device_series_sku, device_series: device_serie)
    end
  end

  describe '#remember_devices' do
    it 'sets instance variable' do
      expect(subject.instance_variable_get(:@devices)).to eq devices
    end
  end

  describe "#devices_parameters" do
    let(:parameters) { FactoryGirl.create_list(:parameter, 4, series: subject) }

    before do
      FactoryGirl.create_list(:sku_parameter, 10, parameter: parameters.first)
    end

    it "returns parameters of device series skus for devices in the cart" do
      expect(subject.devices_parameters).to eq parameters
    end
  end

  describe "#device_series_skus" do
    let(:device_series_skus) { @device_series.select { |device_series| devices.select { |device| device_series.device.id == device.id }.size > 0 } }

    it "returns device series skus for devices in the cart" do
      fail "Refactor it, please. Group by series and return series with associations."

      expect(subject.device_series_skus).to eq device_series_skus
    end
  end
end