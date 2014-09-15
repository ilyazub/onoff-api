require_relative './base'
require_relative './device_group'

module OnOff
  module Models
    class Device < Base
      include DataMapper::Resource

      property :id, Serial
      property :title, String, required: true

      belongs_to :device_group

      property :created_at, DateTime
      property :updated_at, DateTime
    end
  end
end