require 'grape'

require_relative '../models/device'
require_relative '../models/cart'

DataMapper.finalize

module OnOff
  module API
    class Main < ::Grape::API
      format :json

      resource :devices do
        get do
          Models::Device.all
        end
      end
    end
  end
end