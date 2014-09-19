require_relative './base'
require_relative '../entities/cart'

module OnOff
  module API
    module Models
      class Cart < Base
        include DataMapper::Resource

        property :id, UUID, key: true, required: true, default: proc { UUIDTools::UUID.random_create }

        has n, :cart_items

        timestamps :at

        Entity =  Entities::Cart
      end
    end
  end
end