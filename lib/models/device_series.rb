require_relative './base'

require_relative './device'
require_relative './series'
require_relative './manufacturer'

require_relative './sku'
require_relative './tag'

require_relative './device_series_sku'
require_relative './parameter'
require_relative './value'

require_relative './tagging'

require_relative '../entities/device_series'

module OnOff
  module API
    module Models
      class DeviceSeries < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true

        property :device_id, Integer, unique_index: :unique_device_series_manufacturer, required: true
        property :series_id, Integer, unique_index: :unique_device_series_manufacturer, required: true
        property :manufacturer_id, Integer, unique_index: :unique_device_series_manufacturer, required: true

        belongs_to :device
        belongs_to :series, 'Series'
        belongs_to :manufacturer

        has n, :cart_items, through: :device

        has n, :device_series_skus, 'DeviceSeriesSKU', constraint: :destroy
        has n, :skus, 'SKU', through: :device_series_skus
        has n, :parameters, 'Parameter', through: :device_series_skus
        has n, :values, 'Value', through: :parameters

        has n, :taggings, constraint: :destroy
        has n, :tags, through: :taggings

        timestamps :at

        Entity = Entities::DeviceSeries
      end
    end
  end
end