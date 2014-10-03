require_relative './base'
require_relative './device_group'
require_relative './device_series'
require_relative './cart_item'
require_relative './series'
require_relative './manufacturer'

require_relative '../entities/device'

module OnOff
  module API
    module Models
      class Device < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique_index: true

        belongs_to :device_group

        has n, :cart_items, constraint: :destroy
        has n, :carts, through: :cart_items

        has n, :device_series, constraint: :destroy
        has n, :series, through: :device_series
        has n, :manufacturers, through: :device_series

        timestamps :at

        Entity = Entities::Device
      end
    end
  end
end