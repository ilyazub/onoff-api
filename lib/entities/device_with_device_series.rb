require_relative './base'
require_relative './device_series'

module OnOff
  module API
    module Entities
      class DeviceWithDeviceSeries < Base
        expose :id
        expose :title, documentation: { type: 'String' }
        expose :device_group_id
        expose :device_series, using: DeviceSeries
      end
    end
  end
end