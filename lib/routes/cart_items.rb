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
              cart_item = Models::CartItem.get(params[:id])

              if cart_item.update(amount: params[:amount])
                present cart_item
              else
                status 400
                present cart_item.errors
              end
            end

            desc 'Deletes cart item'
            params do
              requires :id, type: Integer
            end
            delete ':id' do
              cart_item = Models::CartItem.get(params[:id])

              if cart_item.destroy
                present cart_item
              else
                status 400
                present cart_item.errors
              end
            end
          end
        end
      end
    end
  end
end