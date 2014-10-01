Dir["#{File.dirname(__FILE__) }/../lib/models/*.rb"].each { |file| require file }

require 'parallel'

module OnOff
  module API
    module DB
      class SeedsLoader
        def initialize
          DataMapper.finalize
          DataMapper.auto_migrate!
          DataMapper.auto_upgrade!

          create_device_groups

          create_devices
          create_series
          create_manufacturers

          create_device_series

          create_stock_keeping_units
          create_device_series_stock_keeping_units

          # create_options
          # create_tags

          # create_device_series_options
          # create_device_series_taggings
        end

        private
          def create_device_groups
            Models::DeviceGroup.create_all([
              { title: 'Розетка' },
              { title: 'Выключатель' },
              { title: 'Диммер' },
              { title: 'Рамка' },
              { title: 'Опция 1' }
            ])
          end

          def create_devices
            device_groups = Models::DeviceGroup.all

            jacks         = device_groups.first(title: 'Розетка')
            switches      = device_groups.first(title: 'Выключатель')
            dimmers       = device_groups.first(title: 'Диммер')
            frames        = device_groups.first(title: 'Рамка')
            first_option  = device_groups.first(title: 'Опция 1')

            Models::Device.create_all([
              { title: 'Розетка', device_group: jacks },
              { title: 'Розетка с крышкой', device_group: jacks },
              { title: 'Выключатель 1 кл.', device_group: switches },
              { title: 'Выключатель 2 кл.', device_group: switches },
              { title: 'Розетка ТВ', device_group: jacks },
              { title: 'Розетка ТВ+Спутник', device_group: jacks },
              { title: 'Розетка компьютерная', device_group: jacks },
              { title: 'Розетка телефонная', device_group: jacks },
              { title: 'Диммер поворотный', device_group: dimmers },
              { title: 'Рамка 1-ая', device_group: frames },
              { title: 'Рамка 2-ая', device_group: frames },
              { title: 'Рамка 3-ая', device_group: frames },
              { title: 'Рамка 4-ая', device_group: frames },
              { title: 'Рамка 5-ая', device_group: frames },
              # { title: 'Декоративная накладка', device_group: first_option }
            ])
          end

          def create_series
            series = Models::Series.create_all([
              { title: 'Basic 55' },
              { title: 'Busch-Duro Reflex' },
              { title: 'Spring' },
              { title: 'Alpha' },
              { title: 'Future/Future Linear' },
              { title: 'Solo' },
              { title: 'Axcent' },
              { title: 'Impuls' },
              { title: 'Steel' },
              { title: 'Carat' }
            ])
          end

          def create_manufacturers
            manufacturers = Models::Manufacturer.create_all([
              { assembly: 'Busch Jaeger', title: 'ABB', country: 'Германия' }
            ])
          end

          def create_device_series
            devices_amount = Models::Device.count
            series_amount = Models::Series.count
            manufacturers_amount = Models::Manufacturer.count

            device_series = (1..devices_amount).to_a.shuffle.map do |device_id|
              (1..series_amount).to_a.shuffle.map do |series_id|
                (1..manufacturers_amount).to_a.shuffle.map do |manufacturer_id|
                  {
                    device_id: device_id,
                    series_id: series_id,
                    manufacturer_id: manufacturer_id
                  }
                end
              end
            end.flatten

            Models::DeviceSeries.create_all(device_series)
          end

          def create_options
            Models::Option.create_all([
              { title: 'Цвет' }
            ])
          end

          def create_device_series_options
            device_series_amount = Models::DeviceSeries.count
            options_amount = Models::Option.count

            options_keys = [
              { variable: "X#{rand(1..options_amount)}", value: '81', description: 'Анрацит' },
              { variable: "X#{rand(1..options_amount)}", value: '82', description: 'Слоновая кость' },
              { variable: "X#{rand(1..options_amount)}", value: '83', description: 'Серебро' },
              { variable: "X#{rand(1..options_amount)}", value: '84', description: 'Белый' },
              { variable: "X#{rand(1..options_amount)}", value: '884', description: 'Белый бархат' },

              { variable: "X#{rand(1..options_amount)}", value: 'В', description: 'Белый' },
              { variable: "X#{rand(1..options_amount)}", value: 'С', description: 'Слоновая кость' },
              { variable: "X#{rand(1..options_amount)}", value: 'D', description: 'Бежевый' },
              { variable: "X#{rand(1..options_amount)}", value: 'S', description: 'Серый' },
              { variable: "X#{rand(1..options_amount)}", value: 'R', description: 'Бордовый' },
              { variable: "X#{rand(1..options_amount)}", value: 'M2', description: 'Голубой' },
              { variable: "X#{rand(1..options_amount)}", value: 'R2', description: 'Кирпичный' },
              { variable: "X#{rand(1..options_amount)}", value: 'S2', description: 'Дымчатый' },
              { variable: "X#{rand(1..options_amount)}", value: 'H', description: 'Табако' },
              { variable: "X#{rand(1..options_amount)}", value: 'N', description: 'Черный' }
            ]

            device_series_options = (1..device_series_amount).to_a.shuffle.map do |device_series|
              (1..options_amount * options_keys.size).to_a.shuffle.map do |option|
                option_key = options_keys.at(option)

                {
                  device_series_id: device_series,
                  option_id: rand(1..options_amount),
                  variable: option_key[:variable],
                  value: option_key[:value],
                  description: option_key[:description]
                }
              end
            end.flatten

            Models::DeviceSeriesOption.create_all(device_series_options)
          end

          def create_tags
            Models::Tag.create_all([
              { title: 'Классический дизайн' },
              { title: 'Натуральные материалы' }
            ])
          end

          def create_device_series_taggings
            tags_amount = Models::Tag.count
            device_series_amount = Models::DeviceSeries.count

            device_series_taggings = (1..device_series_amount).to_a.shuffle.map do |device_series|
              (1..tags_amount).to_a.shuffle.map do |tag|
                {
                  tag_id: tag,
                  device_series_id: device_series
                }
              end
            end.flatten

            Models::DeviceSeriesTagging.create_all(device_series_taggings)
          end

          def create_stock_keeping_units
            options_amount = Models::Option.count

            stock_keeping_units = [
              { title: "8150", price: rand(1..100.0) },
              { title: "5550 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "0209-507", price: rand(1..100.0) },
              { title: "N2288.1 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "N2271.9", price: rand(1..100.0) },
              { title: "0213-507", price: rand(1..100.0) },
              { title: "1803-X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "2006/6 UC-X#{rand(1..options_amount)}-507", price: rand(1..100.0) },
              { title: "2000/6 US", price: rand(1..100.0) },
              { title: "2001/6 U-507  ", price: rand(1..100.0) },
              { title: "2000/6 US-507", price: rand(1..100.0) },
              { title: "2506-X#{rand(1..options_amount)}-507", price: rand(1..100.0) },
              { title: "1786-X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "2006/1 UCGL-X#{rand(1..options_amount)}-507", price: rand(1..100.0) },
              { title: "2000/1 US", price: rand(1..100.0) },
              { title: "2001/6 U-507", price: rand(1..100.0) },
              { title: "2000/1 US-500", price: rand(1..100.0) },
              { title: "2509-X#{rand(1..options_amount)}-500", price: rand(1..100.0) },
              { title: "1789-X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "1786-X#{rand(1..options_amount)}-507", price: rand(1..100.0) },
              { title: "3916-12221", price: rand(1..100.0) },
              { title: "5518G-A03449 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "5518A-A3449 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "5518M-A03459 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "5518E-A03459 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "1228.01 RJ 12-6", price: rand(1..100.0) },
              { title: "5013U-A01105", price: rand(1..100.0) },
              { title: "5014G-A01018 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "5013A-A00215 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "5014M-A00100 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "5013E-A00215 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "5014M-B01018", price: rand(1..100.0) },
              { title: "3557-A01440", price: rand(1..100.0) },
              { title: "3558-A01440", price: rand(1..100.0) },
              { title: "3559-A01445", price: rand(1..100.0) },
              { title: "3557G-A00651 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "3558A-A651 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "3559M-A00651 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "3558E-A00651 X#{rand(1..options_amount)}", price: rand(1..100.0) },
              { title: "2516-3-507", price: rand(1..100.0) }
            ]

            Models::StockKeepingUnit.create_all(stock_keeping_units)
          end

          def create_device_series_stock_keeping_units
            device_series_amount = Models::DeviceSeries.count
            stock_keeping_units_amount = Models::StockKeepingUnit.count

            (1..device_series_amount).to_a.shuffle.map do |device_series|
              stock_keeping_units = (1..stock_keeping_units_amount).to_a.shuffle

              device_series_stock_keeping_units = (1..rand(1..4)).to_a.shuffle.map do |amount|
                stock_keeping_unit = stock_keeping_units.delete(stock_keeping_units.sample)

                {
                  device_series_id: device_series,
                  stock_keeping_unit_id: stock_keeping_unit,
                  amount: amount
                }
              end

              Models::DeviceSeriesStockKeepingUnit.create_all(device_series_stock_keeping_units)
            end
          end
      end
    end
  end
end