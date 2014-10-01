require_relative './base'

module OnOff
  module API
    module Entities
      class Tag < Base
        expose :title, documentation: { type: 'String' }
      end
    end
  end
end