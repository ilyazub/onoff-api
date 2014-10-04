require_relative './base'

require_relative './device_series'
require_relative './device_series_marking'
require_relative './device_series_parameter'

require_relative '../entities/marking'

module OnOff
  module API
    module Models
      class Marking < Base
        include DataMapper::Resource

        property :title, String, required: true, key: true
        property :price, Float, required: true, default: 0.0

        has n, :device_series_markings, 'DeviceSeriesMarking', child_key: [ :marking_title ], constraint: :destroy
        has n, :device_series, through: :device_series_markings
        has n, :parameters, 'DeviceSeriesParameter', through: :device_series

        timestamps :at

        Entity = Entities::Marking
      end
    end
  end
end