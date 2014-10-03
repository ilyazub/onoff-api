require_relative './device_series'
require_relative './marking'
require_relative './device_series_option'
require_relative './device_series_option_value'

require_relative '../entities/device_series_marking'

module OnOff
  module API
    module Models
      class DeviceSeriesMarking < Base
        include DataMapper::Resource

        property :id, Serial, required: true, key: true
        property :amount, Integer, required: true, default: 1

        belongs_to :device_series, 'DeviceSeries'
        belongs_to :marking, parent_key: [ :title ]

        has n, :options, 'DeviceSeriesOption', through: :device_series
        has n, :values, 'DeviceSeriesOptionValue', through: :options

        timestamps :at

        Entity = Entities::DeviceSeriesMarking
      end
    end
  end
end