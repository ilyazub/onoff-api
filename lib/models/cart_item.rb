require_relative './cart'
require_relative './device'

require_relative '../entities/cart_item'

module OnOff
  module API
    module Models
      class CartItem < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :amount, Integer, required: true, default: 1

        belongs_to :cart
        belongs_to :device

        has n, :device_series, through: :device

        timestamps :at

        Entity = Entities::CartItem
      end
    end
  end
end