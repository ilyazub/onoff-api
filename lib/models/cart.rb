require_relative './base'
require_relative './cart_item'
require_relative './selected_value'

require_relative '../entities/cart'

module OnOff
  module API
    module Models
      class Cart < Base
        include DataMapper::Resource

        property :id, UUID, key: true, required: true, default: proc { UUIDTools::UUID.random_create }

        has n, :cart_items, constraint: :destroy
        has n, :selected_values, constraint: :destroy

        timestamps :at

        Entity =  Entities::Cart

        def self.get_or_create(id)
          get(id) || create
        end

        def series()
          devices.series.each do |serie|
            serie.remember_devices(devices)
          end
        end

        def devices() cart_items.devices end

        def specific_devices_amount(device)
          cart_items.all(device: device).inject(0) { |amount, cart_item| amount + cart_item.amount }
        end
      end
    end
  end
end