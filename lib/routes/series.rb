module OnOff
  module API
    class Series < Grape::API
      helpers do
        def current_cart
          if cart = Models::Cart.get(params[:cart_id])
            cart
          else
            error!('No such cart', 400)
          end
        end
      end

      rescue_from ArgumentError do |e|
        Rack::Response.new({
          error: "#{e.class} error",
          message: e.message
          }.to_json, 500).finish
      end

      resource :carts do
        segment '/:cart_id' do
          params do
            requires :cart_id, type: String, desc: 'UUID of the cart'
          end

          resource :series do
            desc 'Get all devices in current cart'
            get do
              present current_cart.series
            end
          end

          resource :values do
            desc 'Selects value'
            params do
              requires :parameter_id
              requires :id
              requires :selected
            end
            put do
              present current_cart.selected_values.first_or_create(parameter_id: params[:parameter_id]).update(value_id: params[:id])
            end
          end
        end
      end
    end
  end
end