require 'dm-timestamps'

module OnOff
  module Models
    class Cart
      include DataMapper::Resource

      property :session_id, String, key: true
      property :created_at, DateTime
      property :updated_at, DateTime
    end
  end
end