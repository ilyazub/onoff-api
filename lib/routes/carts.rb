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
        put '/:id' do
          cart = Models::Cart.get_or_create(params[:id])
          cart.update(updated_at: Time.now)
          present cart
        end

        desc 'Removes all items from cart'
        params do
          requires :id, type: String, desc: 'UUID of the cart'
        end
        delete '/:id' do
          cart = Models::Cart.get_or_create(params[:id])
          cart.cart_items.destroy
          cart.selected_values.destroy

          present cart
        end
      end
    end
  end
end