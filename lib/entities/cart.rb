require_relative './base'

module OnOff
  module API
    module Entities
      class Cart < Base
        expose :id, documentation: { type: 'String', desc: 'UUID of the cart' } do |cart, options|
          cart.id.to_s
        end
      end
    end
  end
end