require_relative './device_series'
require_relative './series'
require_relative './device'

require_relative '../entities/manufacturer'

module OnOff
  module API
    module Models
      class Manufacturer < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique_index: true
        property :country, String, required: true
        property :assembly, String, required: true

        has n, :device_series
        has n, :series, through: :device_series
        has n, :devices, through: :device_series

        timestamps :at

        Entity = Entities::Manufacturer
      end
    end
  end
end