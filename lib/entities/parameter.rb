require_relative './base'

require_relative './device_series'
require_relative './value'

module OnOff
  module API
    module Entities
      class Parameter < Base
        expose :id
        expose :variable, :description, documentation: { type: 'String' }

        expose :values, using: Value
      end
    end
  end
end