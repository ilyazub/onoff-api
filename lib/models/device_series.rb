require_relative './base'

require_relative './device'
require_relative './series'
require_relative './manufacturer'

require_relative './marking'
require_relative './tag'

require_relative './device_series_marking'
require_relative './device_series_parameter'
require_relative './device_series_parameter_value'

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

        has n, :parameters, 'DeviceSeriesParameter', constraint: :destroy
        has n, :values, 'DeviceSeriesParameterValue', through: :parameters, constraint: :destroy

        has n, :device_series_markings, 'DeviceSeriesMarking', constraint: :destroy
        has n, :markings, through: :device_series_markings, constraint: :destroy

        has n, :device_series_taggings, constraint: :destroy
        has n, :tags, through: :device_series_taggings, constraint: :destroy

        timestamps :at

        Entity = Entities::DeviceSeries
      end
    end
  end
end