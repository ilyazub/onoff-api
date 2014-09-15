require_relative './base'

module OnOff
  module Models
    class DeviceGroup < Base
      include DataMapper::Resource

      property :id, Serial
      property :title, String, required: true

      has n, :devices

      property :created_at, DateTime
      property :updated_at, DateTime
    end
  end
end