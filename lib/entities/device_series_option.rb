require_relative './base'

require_relative './device_series'
require_relative './option'

module OnOff
  module API
    module Entities
      class DeviceSeriesOption < Base
        expose :variable, :value, :description, documentation: { type: 'String' }

        expose :device_series, using: DeviceSeries
        expose :option, using: Option
      end
    end
  end
end