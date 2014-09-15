require 'dm-timestamps'

module OnOff
  module Models
    class Device
      include DataMapper::Resource

      property :id, Serial
      property :title, String, required: true
      property :created_at, DateTime
      property :updated_at, DateTime
    end
  end
end