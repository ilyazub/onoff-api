require_relative './base'

module OnOff
  module API
    module Entities
      class Manufacturer < Base
        expose :id
        expose :title, :country, :assembly, documentation: { type: 'String' }
      end
    end
  end
end