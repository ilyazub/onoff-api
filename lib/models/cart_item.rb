require_relative './cart'
require_relative './device'

require_relative '../entities/cart_item'

module OnOff
  module API
    module Models
      class CartItem < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :amount, Integer, required: true, default: 0

        belongs_to :device, required: true
        belongs_to :cart, required: true

        timestamps :at

        Entity = Entities::CartItem

        def self.create_or_update(attributes)
          cart_item = Models::CartItem.first_or_create(attributes.slice(:device_id, :cart_id))

          cart_item.update(amount: cart_item.amount + attributes[:amount].to_i)

          cart_item
        end
      end
    end
  end
end