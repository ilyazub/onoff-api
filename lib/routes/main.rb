require 'grape'
require 'erb'
require 'tilt'
require 'tilt/erb'
require 'erubis'

require_relative './devices'
require_relative './carts'
require_relative './cart_items'
require_relative './series'

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
      end
    end
  end
end