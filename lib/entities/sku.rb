require_relative './base'

module OnOff
  module API
    module Entities
      class SKU < Base
        expose :id, documentation: { type: 'Integer' }
        expose :title, documentation: { type: 'String' }
        expose :unit_price, documentation: { type: 'Float' }
      end
    end
  end
end