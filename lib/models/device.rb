require_relative './base'
require_relative './device_group'
require_relative './device_series'
require_relative './cart_item'

require_relative '../entities/device'

module OnOff
  module API
    module Models
      class Device < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :code, String, required: true, unique_index: :unique_device
        property :title, String, required: true, unique_index: :unique_device

        belongs_to :device_group, required: true

        has n, :cart_items, constraint: :destroy

        has n, :device_series, constraint: :destroy
        has n, :series, through: :device_series

        timestamps :at

        validates_uniqueness_of :title, scope: :code, message: "There's already a device of that title with this code"

        Entity = Entities::Device
      end
    end
  end
end