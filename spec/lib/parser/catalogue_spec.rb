RSpec.describe OnOff::API::Parser::Catalogue do
  subject { OnOff::API::Parser::Catalogue.new }

  describe '#parse_sku' do
    let(:device)  { double(OnOff::API::Models::DeviceSeries) }
    let(:index)   { 0 }

    [ '', '  ', ' ', nil ].each do |title|
      it "skips #{title} title" do
        expect { subject.parse_sku(device, title, index) }.to_not change(OnOff::API::Models::DeviceSeriesSKU, :count)
      end
    end

    context 'when SKU type is an option' do
      let(:title) { 'Опция 9' }

      it 'skips SKU creation' do
        expect { subject.parse_sku(device, title, index) }.to_not change(OnOff::API::Models::DeviceSeriesSKU, :count)
      end
    end
  end
end