module OnOff
  module API
    class Carts < Grape::API
      resource :carts do
        desc 'Initializes a new cart'
        post do
          present Models::Cart.create
        end

        desc 'Gets a cart'
        params do
          requires :id, type: String, desc: 'UUID of the cart'
        end
        get '/:id' do
          present Models::Cart.get(params[:id])
        end

        desc 'Finds or creates a new cart'
        params do
          requires :id, type: String, desc: 'UUID of the cart'
        end
        put '/:id' do
          present Models::Cart.first_or_create({ id: params[:id] }, {})
        end
      end
    end
  end
end