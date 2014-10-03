require_relative './base'

module OnOff
  module API
    module Entities
      class Marking < Base
        expose :title, documentation: { type: 'String' }
        expose :price, documentation: { type: 'Float' }
      end
    end
  end
end