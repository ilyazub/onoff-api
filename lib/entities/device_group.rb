require_relative './base'

module OnOff
  module API
    module Entities
      class DeviceGroup < Base
        expose :id
        expose :title, documentation: { type: 'String' }
      end
    end
  end
end