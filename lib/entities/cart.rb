require_relative './cart_item'

module OnOff
  module API
    module Entities
      class Cart < Base
        expose :id, documentation: { type: 'String', desc: 'UUID of the cart' } do |cart, options|
          cart.id.to_s
        end
        expose :cart_items, using: CartItem
      end
    end
  end
end