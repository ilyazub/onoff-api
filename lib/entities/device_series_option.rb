require_relative './base'

require_relative './device_series'
require_relative './device_series_option_value'

module OnOff
  module API
    module Entities
      class DeviceSeriesOption < Base
        expose :id
        expose :variable, :description, documentation: { type: 'String' }

        expose :device_series_id
        expose :values, using: DeviceSeriesOptionValue
      end
    end
  end
end