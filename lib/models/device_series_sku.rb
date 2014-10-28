require_relative './sku'
require_relative './device_series'
require_relative './parameter'

require_relative '../entities/device_series_sku'

module OnOff
  module API
    module Models
      class DeviceSeriesSKU < Base
        include DataMapper::Resource

        property :id, Serial, required: true, key: true
        property :amount, Integer, required: true, default: 1
        property :layer, Integer, required: true, default: 1

        belongs_to :sku, 'SKU', required: true
        belongs_to :device_series, required: true

        has n, :parameters, constraint: :destroy
        has n, :values, through: :parameters

        timestamps :at

        Entity = Entities::DeviceSeriesSKU

        def device
          device_series.device
        end

        def min_price
          price = if parameters.size
            parameters.min_price
          else
            sku.unit_price
          end

          price * amount
        end
      end
    end
  end
end