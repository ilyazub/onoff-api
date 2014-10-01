require_relative './device_series_tagging'
require_relative './device_series'

require_relative '../entities/tag'

module OnOff
  module API
    module Models
      class Tag < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique_index: true

        has n, :device_series_taggings
        has n, :device_series, through: :device_series_taggings

        timestamps :at

        Entity = Entities::Tag
      end
    end
  end
end