require_relative './device_group'
require_relative '../entities/device'

module OnOff
  module API
    module Models
      class Device < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true

        belongs_to :device_group, required: true
        has n, :cart_items

        timestamps :at

        Entity = Entities::Device
      end
    end
  end
end