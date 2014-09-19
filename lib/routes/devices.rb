require_relative '../models/device'

module OnOff
  module API
    class Devices < Grape::API
      resource :devices do
        get do
          present Models::Device.all
        end
      end
    end
  end
end