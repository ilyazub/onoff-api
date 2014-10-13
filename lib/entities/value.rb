require_relative './base'

module OnOff
  module API
    module Entities
      class Value < Base
        expose :id, documentation: { type: 'Integer' }
        expose :code, :description, documentation: { type: 'String' }
      end
    end
  end
end