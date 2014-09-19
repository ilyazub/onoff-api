require_relative './base'

module OnOff
  module API
    module Entities
      class CartItem < Base
        expose :id, documentation: { type: 'Integer' }
        expose :amount, documentation: { type: 'Integer' }
        expose :device, using: Device
        expose :cart_id, documentation: { type: 'String', desc: 'UUID of the cart' } do |cart_item, options|
          cart_item.cart_id.to_s
        end
      end
    end
  end
end