require_relative './base'
require_relative './series'
require_relative './manufacturer'

require_relative './device_series_marking'
require_relative './device_series_option'

module OnOff
  module API
    module Entities
      class DeviceSeries < Base
        expose :id

        expose :series, using: Series
        expose :manufacturer, using: Manufacturer

        expose :device_series_markings, using: DeviceSeriesMarking
        # expose :options, using: DeviceSeriesOption do |device_series, options|
        #   device_series.options
        # end
      end
    end
  end
end