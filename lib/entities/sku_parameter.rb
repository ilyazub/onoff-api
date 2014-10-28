require_relative './base'
require_relative './sku_value'

module OnOff
  module API
    module Entities
      class SKUParameter < Base
        expose :parameter_id, as: :parameterId

        expose :sku_values, as: :values, using: SKUValue
      end
    end
  end
end