require 'grape'

require_relative '../models/device'
require_relative '../models/cart'

module OnOff
  module API
    class Main < ::Grape::API
      DataMapper.finalize

      format :json

      resource :devices do
        get do
          Models::Device.all
        end
      end
    end
  end
end