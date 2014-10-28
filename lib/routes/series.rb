module OnOff
  module API
    class Series < Grape::API
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
              if cart = Models::Cart.get(params[:cart_id])
                present cart.series
              else
                error!('No such cart', 400)
              end
            end
          end
        end
      end
    end
  end
end