require_relative './base'
require_relative './series'
require_relative './manufacturer'

require_relative './parameter'
require_relative './value'

require_relative './device_series_sku'

module OnOff
  module API
    module Entities
      class DeviceSeries < Base
        expose :id

        expose :series, using: Series
        expose :manufacturer, using: Manufacturer

        expose :device_series_skus, using: DeviceSeriesSKU
      end
    end
  end
end