require 'grape'

require_relative './devices'
require_relative './carts'

module OnOff
  module API
    module Routes
      class Main < ::Grape::API
        DataMapper.finalize

        format :json
        default_format :json

        mount Carts
        mount Devices
      end
    end
  end
end