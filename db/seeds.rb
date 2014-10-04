Dir["#{File.dirname(__FILE__) }/../lib/models/*.rb"].each { |file| require file }

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
          create_device_series_parameters
          create_device_series_parameter_values

          create_markings
          create_device_series_markings

          # create_tags
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
            first_parameter  = device_groups.first(title: 'Опция 1')

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
              # { title: 'Декоративная накладка', device_group: first_parameter }
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

          def create_device_series_parameters
            device_series_amount = Models::DeviceSeries.count

            parameters = [
              { variable: "X1", description: 'Цвет' },
              { variable: "X2", description: 'Цвет' }
            ]

            (1..device_series_amount).to_a.shuffle.map do |device_series_id|
              device_series_parameters = parameters.shuffle.map do |parameter|
                {
                  device_series_id: device_series_id,
                  variable: parameter[:variable],
                  description: parameter[:description]
                }
              end

              Models::DeviceSeriesParameter.create_all(device_series_parameters)
            end
          end

          def create_device_series_parameter_values
            device_series_parameters_amount = Models::DeviceSeriesParameter.count

            values = [
              { code: '81', description: 'Анрацит' },
              { code: '82', description: 'Слоновая кость' },
              { code: '83', description: 'Серебро' },
              { code: '84', description: 'Белый' },
              { code: '884', description: 'Белый бархат' },
              { code: 'В', description: 'Белый' },
              { code: 'С', description: 'Слоновая кость' },
              { code: 'D', description: 'Бежевый' },
              { code: 'S', description: 'Серый' },
              { code: 'R', description: 'Бордовый' },
              { code: 'M2', description: 'Голубой' },
              { code: 'R2', description: 'Кирпичный' },
              { code: 'S2', description: 'Дымчатый' },
              { code: 'H', description: 'Табако' },
              { code: 'N', description: 'Черный' }
            ]

            (1..device_series_parameters_amount).to_a.shuffle.map do |device_series_parameter_id|
              device_series_parameter_values = values.shuffle.map do |value|
                {
                  parameter_id: device_series_parameter_id,
                  code: value[:code],
                  description: value[:description]
                }
              end

              Models::DeviceSeriesParameterValue.create_all(device_series_parameter_values)
            end
          end

          def create_markings
            device_series_parameters_amount = Models::DeviceSeriesParameter.distinct(:variable).to_a.count

            markings = [
              { title: "8150", price: rand(1..100.0) },
              { title: "5550 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "0209-507", price: rand(1..100.0) },
              { title: "N2288.1 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "N2271.9", price: rand(1..100.0) },
              { title: "0213-507", price: rand(1..100.0) },
              { title: "1803-X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "2006/6 UC-X#{rand(1..device_series_parameters_amount)}-507", price: rand(1..100.0) },
              { title: "2000/6 US", price: rand(1..100.0) },
              { title: "2001/6 U-507  ", price: rand(1..100.0) },
              { title: "2000/6 US-507", price: rand(1..100.0) },
              { title: "2506-X#{rand(1..device_series_parameters_amount)}-507", price: rand(1..100.0) },
              { title: "1786-X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "2006/1 UCGL-X#{rand(1..device_series_parameters_amount)}-507", price: rand(1..100.0) },
              { title: "2000/1 US", price: rand(1..100.0) },
              { title: "2001/6 U-507", price: rand(1..100.0) },
              { title: "2000/1 US-500", price: rand(1..100.0) },
              { title: "2509-X#{rand(1..device_series_parameters_amount)}-500", price: rand(1..100.0) },
              { title: "1789-X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "1786-X#{rand(1..device_series_parameters_amount)}-507", price: rand(1..100.0) },
              { title: "3916-12221", price: rand(1..100.0) },
              { title: "5518G-A03449 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "5518A-A3449 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "5518M-A03459 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "5518E-A03459 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "1228.01 RJ 12-6", price: rand(1..100.0) },
              { title: "5013U-A01105", price: rand(1..100.0) },
              { title: "5014G-A01018 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "5013A-A00215 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "5014M-A00100 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "5013E-A00215 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "5014M-B01018", price: rand(1..100.0) },
              { title: "3557-A01440", price: rand(1..100.0) },
              { title: "3558-A01440", price: rand(1..100.0) },
              { title: "3559-A01445", price: rand(1..100.0) },
              { title: "3557G-A00651 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "3558A-A651 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "3559M-A00651 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "3558E-A00651 X#{rand(1..device_series_parameters_amount)}", price: rand(1..100.0) },
              { title: "2516-3-507", price: rand(1..100.0) }
            ]

            Models::Marking.create_all(markings)
          end

          def create_device_series_markings
            device_series_amount = Models::DeviceSeries.count
            markings = Models::Marking.all(fields: [ :title ])

            (1..device_series_amount).to_a.shuffle.map do |device_series|
              markings_dup = markings.dup

              device_series_markings = (1..rand(1..4)).to_a.shuffle.map do |amount|
                marking = markings_dup.sample
                markings_dup -= [marking]

                {
                  device_series_id: device_series,
                  marking_title: marking.title,
                  amount: amount
                }
              end

              Models::DeviceSeriesMarking.create_all(device_series_markings)
            end
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
      end
    end
  end
end