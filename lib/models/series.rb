require_relative './device_series'
require_relative './device'
require_relative './manufacturer'
require_relative './device_series_stock_keeping_unit'
require_relative './device_series_option'
require_relative './device_series_tagging'

require_relative '../entities/series'

module OnOff
  module API
    module Models
      class Series < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique_index: true

        has n, :device_series

        has n, :devices, through: :device_series
        has n, :manufacturer, 'Manufacturer', through: :device_series

        has n, :device_series_stock_keeping_units, through: :device_series
        has n, :device_series_options, through: :device_series
        has n, :device_series_taggings, through: :device_series

        timestamps :at

        Entity = Entities::Series
      end
    end
  end
end