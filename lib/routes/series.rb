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

            segment '/:series_id' do
              params do
                requires :series_id, type: Integer
              end

              format :txt
              content_type :txt, 'text/xml'
              content_type :xls, 'application/vnd.ms-excel'

              get ':title' do
                device_series_skus = current_cart.devices.device_series.all(series_id: params[:series_id]).device_series_skus

                template = File.expand_path('../../templates/skus.xls.erb', __FILE__)
                Tilt::ERBTemplate.new(template).render(Object.new, cart: current_cart, series_id: params[:series_id], skus: device_series_skus)
              end
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
              present current_cart.selected_values.get_or_create(cart_id: current_cart.id, parameter_id: params[:parameter_id], value_id: params[:id])
            end
          end
        end
      end
    end
  end
end