require_relative './base'
require_relative '../entities/cart'

module OnOff
  module API
    module Models
      class Cart < Base
        include DataMapper::Resource

        property :id, UUID, key: true, required: true, default: proc { UUIDTools::UUID.random_create }

        timestamps :at

        def entity
          Entities::Cart.new(self)
        end
      end
    end
  end
end