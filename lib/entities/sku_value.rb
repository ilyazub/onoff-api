require_relative './base'

module OnOff
  module API
    module Entities
      class SKUValue < Base
        expose :value_id, as: :valueId
        expose :unit_price, as: :unitPrice
      end
    end
  end
end