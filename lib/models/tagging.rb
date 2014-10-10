require_relative './tag'
require_relative './device_series'

require_relative '../entities/tagging'

module OnOff
  module API
    module Models
      class Tagging < Base
        include DataMapper::Resource

        belongs_to :tag, parent_key: [ :title ], key: true
        belongs_to :device_series, key: true

        timestamps :at

        Entity = Entities::Tagging
      end
    end
  end
end