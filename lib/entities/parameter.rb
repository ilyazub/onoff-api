require_relative './base'
require_relative './value'

module OnOff
  module API
    module Entities
      class Parameter < Base
        expose :id, :variable, :description

        expose :values, using: Value
      end
    end
  end
end