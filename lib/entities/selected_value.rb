require_relative './base'

module OnOff
  module API
    module Entities
      class SelectedValue < Base
        expose :stringified_cart_id, as: :cartId
        expose :parameter_id, as: :parameterId
        expose :value_id, as: :valueId
      end
    end
  end
end