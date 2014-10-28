require_relative './manufacturer'
require_relative './device_series'

require_relative '../entities/series'

module OnOff
  module API
    module Models
      class Series < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique: :manufacturer_id

        belongs_to :manufacturer, required: true

        has n, :device_series, constraint: :destroy
        has n, :devices, through: :device_series

        timestamps :at

        Entity = Entities::Series

        def parameters() device_series.parameters end
        def device_series_skus() device_series.device_series_skus end
      end
    end
  end
end