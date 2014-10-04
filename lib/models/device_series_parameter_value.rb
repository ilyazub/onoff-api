require_relative './device_series_parameter'

require_relative '../entities/device_series_parameter_value'

module OnOff
  module API
    module Models
      class DeviceSeriesParameterValue < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :code, String, required: true
        property :description, String, required: true

        belongs_to :parameter, 'DeviceSeriesParameter'

        timestamps :at

        Entity = Entities::DeviceSeriesParameterValue
      end
    end
  end
end