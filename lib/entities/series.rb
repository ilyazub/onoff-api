require_relative './base'
require_relative './device_group'

module OnOff
  module API
    module Entities
      class Series < Base
        expose :id
        expose :title
        expose :device_groups, as: :deviceGroups, using: DeviceGroup
      end
    end
  end
end