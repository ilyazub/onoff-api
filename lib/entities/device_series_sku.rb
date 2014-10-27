require_relative './base'
require_relative './sku'
require_relative './parameter'

module OnOff
  module API
    module Entities
      class DeviceSeriesSKU < Base
        expose :id, :amount, :layer

        expose :sku, using: SKU

        expose :parameters, using: Parameter
      end
    end
  end
end