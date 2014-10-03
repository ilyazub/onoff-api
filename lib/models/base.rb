require 'dm-timestamps'
require 'dm-constraints'

module OnOff
  module API
    module Models
      class Base
        def self.create_all(list)
          list.map do |item|
            create item
          end
        end

        def self.distinct(property)
          all(fields: [ property ], unique: true, order: [ property.asc ])
        end
      end
    end
  end
end