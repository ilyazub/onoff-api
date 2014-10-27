require_relative './base'
require_relative './manufacturer'
require_relative './device_series_sku'

module OnOff
  module API
    module Entities
      class Series < Base
        expose :id, :title

        expose :manufacturer, using: Manufacturer

        expose :device_series_skus, as: :skus, using: DeviceSeriesSKU
      end
    end
  end
end