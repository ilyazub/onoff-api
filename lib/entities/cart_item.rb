require_relative './base'
require_relative './device'
require_relative './selected_value'

module OnOff
  module API
    module Entities
      class CartItem < Base
        expose :id
        expose :amount
        expose :device, using: Device
        expose :selected_values, using: SelectedValue
      end
    end
  end
end