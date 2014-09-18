require_relative '../models/cart'

module OnOff
  module API
    class Carts < Grape::API
      desc 'Initializes a new cart'
      post do
        Models::Cart.create
      end

      desc 'Finds or creates a new cart'
      params do
        requires :id, type: String, desc: 'UUID of the cart'
      end
      put ':id' do
        cart = Models::Cart.first_or_create({}, id: params[:id])
      end
    end
  end
end