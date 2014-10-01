require_relative './base'

require_relative './device'
require_relative './series'
require_relative './manufacturer'

require_relative './device_series_stock_keeping_unit'
require_relative './device_series_option'

require_relative './tag'
require_relative './device_series_tagging'

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

        has n, :device_series_stock_keeping_units
        has n, :stock_keeping_units, through: :device_series_stock_keeping_units

        has n, :device_series_options
        has n, :options, through: :device_series_options

        has n, :device_series_taggings
        has n, :tags, through: :device_series_taggings

        timestamps :at

        Entity = Entities::DeviceSeries
      end
    end
  end
end