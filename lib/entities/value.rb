require_relative './base'

module OnOff
  module API
    module Entities
      class Value < Base
        expose :id, documentation: { type: 'Integer' }
        expose :code, :description, documentation: { type: 'String' }
        expose :unit_price, documentation: { type: 'Float' }
        expose :selected_by_default, documentation: { type: 'Boolean' }
      end
    end
  end
end