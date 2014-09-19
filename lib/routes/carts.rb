require_relative '../models/cart'
require_relative '../models/cart_item'

module OnOff
  module API
    class Carts < Grape::API
      resource :carts do
        desc 'Initializes a new cart'
        post do
          present Models::Cart.create
        end

        desc 'Finds or creates a new cart'
        params do
          requires :id, type: String, desc: 'UUID of the cart'
        end
        put ':id' do
          present Models::Cart.first_or_create({}, id: params[:id])
        end

        segment '/:cart_id' do
          params do
            requires :cart_id, type: String, desc: 'UUID of the cart'
          end
          resource :items do
            desc 'Add a new cart item'
            params do
              requires :device_id, type: Integer, desc: 'Id of device'
              requires :amount, type: Integer, desc: 'Amount of added devices'
            end
            post do
              present Models::CartItem.create_or_update(params.slice(:cart_id, :device_id, :amount))
            end

            desc 'Updates cart item'
            params do
              requires :id, type: Integer
            end
            put ':id' do
              present Models::CartItem.get(params[:id]).update(amount: params[:amount])
            end

            desc 'Deletes cart item'
            params do
              requires :id, type: Integer
            end
            delete ':id' do
              present Models::CartItem.get(params[:id]).destroy
            end
          end
        end
      end
    end
  end
end