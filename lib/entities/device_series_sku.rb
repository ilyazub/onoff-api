require_relative './base'

require_relative './device_series'
require_relative './sku'
require_relative './parameter'

module OnOff
  module API
    module Entities
      class DeviceSeriesSKU < Base
        expose :amount, :layer

        expose :sku, using: SKU
        expose :parameters, using: Parameter
      end
    end
  end
end