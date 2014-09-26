require_relative './device_series'
require_relative './device'
require_relative './manufacturer'

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
        has n, :manufacturers, through: :device_series

        timestamps :at

        Entity = Entities::Series
      end
    end
  end
end