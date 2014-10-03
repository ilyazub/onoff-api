require_relative './base'

require_relative './device_series'
require_relative './marking'

require_relative './device_series_option'
require_relative './device_series_option_value'

module OnOff
  module API
    module Entities
      class DeviceSeriesMarking < Base
        expose :amount
        expose :marking, using: Marking
        expose :options, using: DeviceSeriesOption do |marking, options|
          marking.options
        end
      end
    end
  end
end