require_relative './device_series_option'

require_relative '../entities/device_series_option_value'

module OnOff
  module API
    module Models
      class DeviceSeriesOptionValue < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :code, String, required: true
        property :description, String, required: true

        belongs_to :option, 'DeviceSeriesOption'

        timestamps :at

        Entity = Entities::DeviceSeriesOptionValue
      end
    end
  end
end