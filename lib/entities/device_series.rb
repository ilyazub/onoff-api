require_relative './base'
require_relative './series'
require_relative './manufacturer'

require_relative './device_series_marking'

module OnOff
  module API
    module Entities
      class DeviceSeries < Base
        expose :id

        expose :series, using: Series
        expose :manufacturer, using: Manufacturer

        expose :device_series_markings, using: DeviceSeriesMarking
      end
    end
  end
end