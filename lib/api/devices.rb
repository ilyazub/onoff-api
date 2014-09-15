module OnOff
  module API
    class Devices < Grape::API
      get do
        Models::Device.all
      end
    end
  end
end