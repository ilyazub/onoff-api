require 'dm-timestamps'
require 'dm-constraints'

require_relative '../../config/database'

module OnOff
  module API
    module Models
      class Base
        def self.create_all(list)
          list.map do |item|
            create item
          end
        end
      end
    end
  end
end