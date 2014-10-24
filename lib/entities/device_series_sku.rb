require_relative './base'
require_relative './sku'
require_relative './sku_parameter'

module OnOff
  module API
    module Entities
      class DeviceSeriesSKU < Base
        expose :id, :amount, :layer

        expose :title do |device_series_sku|
          device_series_sku.sku.title
        end

        expose :unit_price, as: :unitPrice do |device_series_sku|
          device_series_sku.sku.unit_price
        end

        expose :parameters, using: SKUParameter
      end
    end
  end
end