require_relative './device_series_tagging'
require_relative './device_series'

require_relative '../entities/tag'

module OnOff
  module API
    module Models
      class Tag < Base
        include DataMapper::Resource

        property :title, String, required: true, key: true

        has n, :device_series_taggings, child_key: [ :tag, :device_series_id ], constraint: :destroy
        has n, :device_series, through: :device_series_taggings

        timestamps :at

        Entity = Entities::Tag
      end
    end
  end
end