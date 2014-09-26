require_relative './base'
require_relative './device'
require_relative './series'

module OnOff
  module API
    module Entities
      class CartItem < Base
        expose :id, documentation: { type: 'Integer' }
        expose :amount, documentation: { type: 'Integer' }
        expose :device, using: Device
        expose :series, using: Series do |cart_item, options|
          cart_item.device.series
        end
      end
    end
  end
end