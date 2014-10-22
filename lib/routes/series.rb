module OnOff
  module API
    class Series < Grape::API
      resource :carts do
        segment '/:cart_id' do
          params do
            requires :cart_id, type: String, desc: 'UUID of the cart'
          end

          resource :series do
            desc 'Get all devices in current cart'
            get do
              present Models::Cart.get(params[:cart_id]).series
            end
          end
        end
      end
    end
  end
end