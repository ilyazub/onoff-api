require_relative './sku'
require_relative './device_series'
require_relative './sku_parameter'

require_relative '../entities/device_series_sku'

module OnOff
  module API
    module Models
      class DeviceSeriesSKU < Base
        include DataMapper::Resource

        property :id, Serial, required: true, key: true
        property :amount, Integer, required: true, default: 1
        property :layer, Integer, required: true, default: 1
        property :unit_price, Float, required: true, default: 0.0

        belongs_to :sku, 'SKU', required: true
        belongs_to :device_series, required: true

        has n, :sku_parameters, 'SKUParameter', constraint: :destroy

        timestamps :at

        Entity = Entities::DeviceSeriesSKU

        def title() sku.title end
        def device_id() device.id end
        def device() device_series.device end
      end
    end
  end
end