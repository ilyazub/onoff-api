require_relative './base'
require_relative './device'

module OnOff
  module API
    module Entities
      class CartItem < Base
        expose :id
        expose :amount, documentation: { type: 'Integer' }
        expose :device, using: Device
      end
    end
  end
end