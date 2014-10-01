require_relative './device_series'
require_relative './option'

require_relative '../entities/device_series_option'

module OnOff
  module API
    module Models
      class DeviceSeriesOption < Base
        include DataMapper::Resource

        property :variable, String, required: true
        property :value, String, required: true
        property :description, String, required: true

        belongs_to :device_series, 'DeviceSeries', key: true
        belongs_to :option, key: true

        timestamps :at

        Entity = Entities::DeviceSeriesOption
      end
    end
  end
end