require 'grape'

require_relative './devices'
require_relative './carts'
require_relative './cart_items'
require_relative './series'
require_relative '../admin/routes/main'

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
        mount Series
        mount Admin::Main => '/admin'
      end
    end
  end
end