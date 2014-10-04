require_relative './device_series_marking'
require_relative './device_series_parameter_value'

require_relative '../entities/device_series_parameter'

module OnOff
  module API
    module Models
      class DeviceSeriesParameter < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :variable, String, required: true
        property :description, String, required: true

        belongs_to :device_series, 'DeviceSeries'

        has n, :values, 'DeviceSeriesParameterValue', child_key: [ :parameter_id ], constraint: :destroy

        timestamps :at

        Entity = Entities::DeviceSeriesParameter
      end
    end
  end
end