module OnOff
  module API
    class CartItems < Grape::API
      resource :carts do
        segment '/:cart_id' do
          params do
            requires :cart_id, type: String, desc: 'UUID of the cart'
          end

          resource :cart_items do
            desc 'Add a new cart item'
            params do
              requires :device_id, type: Integer, desc: 'Id of device'
              requires :amount, type: Integer, desc: 'Amount of added devices'
            end
            post do
              present Models::CartItem.create(params.slice(:cart_id, :device_id, :amount))
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

          resource :series do
            desc 'Get all series of devices in cart'
            get do
              present Models::Cart.get(params[:cart_id]).devices.series
            end
          end
        end
      end
    end
  end
end