require_relative './base'
require_relative './sku_parameter'

module OnOff
  module API
    module Entities
      class DeviceSeriesSKU < Base
        expose :id, :amount

        expose :device_id, as: :deviceId
        expose :title
        expose :unit_price, as: :unitPrice

        expose :sku_parameters, as: :parameters, using: SKUParameter
      end
    end
  end
end