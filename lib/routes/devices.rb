module OnOff
  module API
    class Devices < Grape::API
      resource :devices do
        get do
          present Models::Device.all
        end

        segment '/:device_id' do
          resource :device_series do
            desc 'Get all device series of device'
            get do
              present Models::Device.get(params[:device_id]).device_series
            end
          end
        end
      end
    end
  end
end