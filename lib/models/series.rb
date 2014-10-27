require_relative './manufacturer'
require_relative './device_series'

require_relative '../entities/series'

module OnOff
  module API
    module Models
      class Series < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique: true

        belongs_to :manufacturer

        has n, :device_series, constraint: :destroy
        has n, :devices, through: :device_series
        has n, :device_series_skus, 'DeviceSeriesSKU', through: :device_series
        has n, :taggings, through: :device_series

        timestamps :at

        Entity = Entities::Series
      end
    end
  end
end