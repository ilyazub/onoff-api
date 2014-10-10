require_relative './tagging'
require_relative './device_series'

require_relative '../entities/tag'

module OnOff
  module API
    module Models
      class Tag < Base
        include DataMapper::Resource

        property :title, String, required: true, key: true

        has n, :taggings, child_key: [ :tag, :device_series_id ], constraint: :destroy
        has n, :device_series, through: :taggings

        timestamps :at

        Entity = Entities::Tag
      end
    end
  end
end