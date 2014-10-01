require_relative './device_series'
require_relative './device_series_option'

require_relative '../entities/option'

module OnOff
  module API
    module Models
      class Option < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique_index: true

        has n, :device_series_options
        has n, :device_series, through: :device_series_options

        timestamps :at

        Entity = Entities::Option
      end
    end
  end
end