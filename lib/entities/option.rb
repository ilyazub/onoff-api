require_relative './base'

module OnOff
  module API
    module Entities
      class Option < Base
        expose :id
        expose :title, documentation: { type: 'String' }
      end
    end
  end
end