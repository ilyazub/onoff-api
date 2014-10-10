require_relative './base'
require_relative './series'
require_relative './manufacturer'

require_relative './parameter'
require_relative './parameter_value'

require_relative './device_series_sku'

module OnOff
  module API
    module Entities
      class DeviceSeries < Base
        expose :id

        expose :series, using: Series
        expose :manufacturer, using: Manufacturer

        expose :parameters, using: Parameter

        expose :device_series_skus, using: DeviceSeriesSKU
      end
    end
  end
end