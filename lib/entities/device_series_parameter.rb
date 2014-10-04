require_relative './base'

require_relative './device_series'
require_relative './device_series_parameter_value'

module OnOff
  module API
    module Entities
      class DeviceSeriesParameter < Base
        expose :id
        expose :variable, :description, documentation: { type: 'String' }

        expose :device_series_id
        expose :values, using: DeviceSeriesParameterValue
      end
    end
  end
end