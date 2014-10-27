require_relative './base'
require_relative './cart_item'

module OnOff
  module API
    module Entities
      class Cart < Base
        expose :id do |cart|
          cart.id.to_s
        end

        expose :cart_items, as: :cartItems, using: CartItem
      end
    end
  end
end