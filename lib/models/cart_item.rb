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

        belongs_to :cart
        belongs_to :device

        timestamps :at

        Entity = Entities::CartItem

        def self.create_or_update(attributes)
          first_or_create(attributes.slice(:device_id, :cart_id))
          update(amount: amount + attributes[:amount].to_i)

          self
        end
      end
    end
  end
end