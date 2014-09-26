require 'grape'

require_relative './carts'
require_relative './devices'
require_relative './cart_items'

module OnOff
  module API
    module Routes
      class Main < ::Grape::API
        DataMapper.finalize

        format :json
        default_format :json

        mount Devices
        mount Carts
        mount CartItems
      end
    end
  end
end