module OnOff
  module API
    class Devices < Grape::API
      resource :devices do
        get do
          present Models::Device.all(display_on_page: true)
        end
      end
    end
  end
end