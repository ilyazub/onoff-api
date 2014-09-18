require 'grape'

require_relative '../models/device_group'
require_relative '../models/device'
require_relative '../models/cart'

module OnOff
  module API
    module Routes
      class Main < ::Grape::API
        DataMapper.finalize

        format :json
        default_format :json

        resource :carts do
          desc 'Initializes a new cart'
          post do
            present Models::Cart.create, with: Entities::Cart
          end

          desc 'Finds or creates a new cart'
          params do
            requires :id, type: String, desc: 'UUID of the cart'
          end
          put ':id' do
            cart = Models::Cart.first_or_create({}, id: params[:id])
            present cart, with: Entities::Cart
          end
        end

        resource :devices do
          get do
            present Models::Device.all, with: Entities::Device
          end
        end
      end
    end
  end
end