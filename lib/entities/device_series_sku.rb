require_relative './base'

require_relative './device_series'
require_relative './sku'
require_relative './sku_parameter'

module OnOff
  module API
    module Entities
      class DeviceSeriesSKU < Base
        expose :amount

        expose :sku, using: SKU
        expose :sku_parameters, using: SKUParameter
      end
    end
  end
end