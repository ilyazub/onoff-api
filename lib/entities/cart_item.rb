require_relative './base'
require_relative './device_with_device_series'

module OnOff
  module API
    module Entities
      class CartItem < Base
        expose :id
        expose :amount, documentation: { type: 'Integer' }
        expose :device, using: DeviceWithDeviceSeries
      end
    end
  end
end