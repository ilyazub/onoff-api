require_relative './base'
require_relative './device_group'

module OnOff
  module API
    module Entities
      class Series < Base
        expose :id
        expose :title, documentation: { type: 'String' }
        expose :device_groups, using: DeviceGroup
      end
    end
  end
end