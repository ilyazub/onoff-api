require_relative './base'

require_relative './device_series'
require_relative './marking'

require_relative './device_series_parameter'
require_relative './device_series_parameter_value'

module OnOff
  module API
    module Entities
      class DeviceSeriesMarking < Base
        expose :amount
        expose :marking, using: Marking
        expose :parameters, using: DeviceSeriesParameter do |marking, options|
          marking.parameters
        end
      end
    end
  end
end