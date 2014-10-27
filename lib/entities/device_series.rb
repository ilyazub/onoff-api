require_relative './base'
require_relative './series'
require_relative './device_series_sku'

module OnOff
  module API
    module Entities
      class DeviceSeries < Base
        expose :id

        expose :series, using: Series

        expose :device_series_skus, as: :deviceSeriesSkus, using: DeviceSeriesSKU
      end
    end
  end
end