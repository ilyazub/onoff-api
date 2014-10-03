require_relative './device_series_marking'
require_relative './device_series_option_value'

require_relative '../entities/device_series_option'

module OnOff
  module API
    module Models
      class DeviceSeriesOption < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :variable, String, required: true
        property :description, String, required: true

        belongs_to :device_series, 'DeviceSeries'

        has n, :values, 'DeviceSeriesOptionValue', child_key: [ :option_id ], constraint: :destroy

        timestamps :at

        Entity = Entities::DeviceSeriesOption
      end
    end
  end
end