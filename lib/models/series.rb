require_relative './base'
require_relative './manufacturer'
require_relative './device_series'
require_relative './parameter'

require_relative '../entities/series'

module OnOff
  module API
    module Models
      class Series < Base
        include DataMapper::Resource

        property :id,     Serial, key: true, required: true
        property :title,  String, required: true

        belongs_to  :manufacturer, required: true
        has n,      :device_series, constraint: :destroy
        has n,      :devices, through: :device_series
        has n,      :parameters

        timestamps :at

        Entity = Entities::Series

        def remember_devices(devices = [])
          @devices = devices
        end

        def devices_parameters
          parameters.all(sku_parameters: device_series_skus.sku_parameters)
        end

        def device_series_skus
          device_series.all(device: @devices).device_series_skus
        end
      end
    end
  end
end