require_relative './base'
# require_relative './parameter'
# require_relative './sku'

module OnOff
  module API
    module Entities
      class DeviceGroup < Base
        expose :id
        expose :title, documentation: { type: 'String' }
        # expose :parameters, using: Parameter
        # expose :skus, using: SKU
      end
    end
  end
end