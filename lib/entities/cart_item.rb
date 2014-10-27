require_relative './base'
require_relative './device'

module OnOff
  module API
    module Entities
      class CartItem < Base
        expose :id, :amount

        expose :device, using: Device
      end
    end
  end
end