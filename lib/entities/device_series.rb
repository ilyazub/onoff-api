require_relative './base'
require_relative './series'
require_relative './manufacturer'

require_relative './device_series_stock_keeping_unit'
# require_relative './device_series_option'

module OnOff
  module API
    module Entities
      class DeviceSeries < Base
        expose :id

        expose :series, using: Series
        expose :manufacturer, using: Manufacturer

        expose :device_series_stock_keeping_units, using: DeviceSeriesStockKeepingUnit
        # expose :device_series_options, using: DeviceSeriesOption
      end
    end
  end
end