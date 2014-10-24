require_relative './base'
require_relative './parameter'
require_relative './device_series_sku'

module OnOff
  module API
    module Entities
      class DeviceGroup < Base
        expose :id
        expose :title
        expose :parameters, using: Parameter
        expose :device_series_skus, as: :skus, using: DeviceSeriesSKU
      end
    end
  end
end