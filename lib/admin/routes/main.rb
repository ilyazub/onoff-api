require_relative '../entities/device_group'
require_relative '../entities/range'

module OnOff
  module API
    module Routes
      module Admin
        class Main < Grape::API
          resource :device_groups do
            get do
              present Models::DeviceGroup.all, with: OnOff::API::Admin::Entities::DeviceGroup
            end
          end

          resource :ranges do
            get do
              present Models::Series.all, with: OnOff::API::Admin::Entities::Range
            end
          end
        end
      end
    end
  end
end