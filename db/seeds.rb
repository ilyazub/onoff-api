Dir["#{File.dirname(__FILE__) }/../lib/models/*.rb"].each { |file| require file }

module OnOff
  module API
    module DB
      class SeedsLoader
        attr_accessor :variable_pattern

        def initialize
          DataMapper.finalize
          DataMapper.auto_migrate!
          DataMapper.auto_upgrade!

          return unless ENV['API_ENV'] == 'development'

          @variable_pattern = '{{variable}}'

          create_device_groups
          create_devices

          create_manufacturers
          create_series

          create_device_series

          create_skus
          create_device_series_skus

          create_parameters
          create_values

          create_sku_parameters
          create_sku_values

          # create_tags
          # create_taggings
        end

        private
          def create_device_groups
            Models::DeviceGroup.bulk_create([
              { title: 'Рамка' },
              { title: 'Розетка' },
              { title: 'Выключатель' },
              { title: 'Диммер' }
            ])
          end

          def create_devices
            device_groups = Models::DeviceGroup.all

            frames    = device_groups.first(title: 'Рамка')
            sockets   = device_groups.first(title: 'Розетка')
            switches  = device_groups.first(title: 'Выключатель')
            dimmers   = device_groups.first(title: 'Диммер')

            Models::Device.bulk_create([
              { title: 'Рамка 1-ая',            device_group: frames },
              # { title: 'Рамка 2-ая',            device_group: frames },
              # { title: 'Рамка 3-ая',            device_group: frames },
              # { title: 'Рамка 4-ая',            device_group: frames },
              # { title: 'Рамка 5-ая',            device_group: frames },
              # { title: 'Розетка',               device_group: sockets },
              # { title: 'Розетка с крышкой',     device_group: sockets },
              # { title: 'Розетка ТВ',            device_group: sockets },
              # { title: 'Розетка ТВ+Спутник',    device_group: sockets },
              # { title: 'Розетка компьютерная',  device_group: sockets },
              # { title: 'Розетка телефонная',    device_group: sockets },
              # { title: 'Выключатель 1 кл.',     device_group: switches },
              { title: 'Выключатель 2 кл.',     device_group: switches },
              { title: 'Диммер поворотный',     device_group: dimmers }
            ])
          end

          def create_manufacturers
            Models::Manufacturer.bulk_create([
              { assembly: 'Busch Jaeger', title: 'ABB', country: 'Германия' }
            ])
          end

          def create_series
            manufacturer = Models::Manufacturer.first

            Models::Series.bulk_create([
              { title: 'Basic 55', manufacturer: manufacturer },
              { title: 'Busch-Duro Reflex', manufacturer: manufacturer },
              # { title: 'Spring', manufacturer: manufacturer },
              # { title: 'Alpha', manufacturer: manufacturer },
              # { title: 'Future/Future Linear', manufacturer: manufacturer },
              # { title: 'Solo', manufacturer: manufacturer },
              # { title: 'Axcent', manufacturer: manufacturer },
              # { title: 'Impuls', manufacturer: manufacturer },
              # { title: 'Steel', manufacturer: manufacturer },
              # { title: 'Carat', manufacturer: manufacturer }
            ])
          end

          def create_device_series
            devices_amount = Models::Device.count
            series_amount = Models::Series.count

            (1..devices_amount).to_a.shuffle.map do |device_id|
              device_series = (1..series_amount).to_a.shuffle.map do |series_id|
                {
                  device_id:  device_id,
                  series_id:  series_id
                }
              end

              Models::DeviceSeries.bulk_create(device_series)
            end
          end

          def create_skus
            skus = [
              { title: "8150" },
              { title: "5550 #{@variable_pattern}" },
              { title: "0209-507" },
              { title: "N2288.1 #{@variable_pattern}" },
              # { title: "N2271.9" },
              # { title: "0213-507" },
              # { title: "1803-#{@variable_pattern}" },
              # { title: "2006/6 UC-#{@variable_pattern}-507" },
              # { title: "2000/6 US" },
              # { title: "2001/6 U-507  " },
              # { title: "2000/6 US-507" },
              # { title: "2506-#{@variable_pattern}" },
              # { title: "1786-#{@variable_pattern}" },
              # { title: "2006/1 UCGL-#{@variable_pattern}" },
              # { title: "2000/1 US" },
              # { title: "2001/6 U-507" },
              # { title: "2000/1 US-500" },
              # { title: "2509-#{@variable_pattern}-500" },
              # { title: "1789-#{@variable_pattern}" },
              # { title: "1786-#{@variable_pattern}-507" },
              # { title: "1721-#{@variable_pattern}" },
              # { title: "3916-12221" },
              # { title: "5518G-A03449 #{@variable_pattern}" },
              # { title: "5518A-A3449 #{@variable_pattern}" },
              # { title: "5518M-A03459 #{@variable_pattern}" },
              # { title: "5518E-A03459 #{@variable_pattern}" },
              # { title: "1228.01 RJ 12-6" },
              # { title: "5013U-A01105" },
              # { title: "5014G-A01018 #{@variable_pattern}" },
              # { title: "5013A-A00215 #{@variable_pattern}" },
              # { title: "5014M-A00100 #{@variable_pattern}" },
              # { title: "5013E-A00215 #{@variable_pattern}" },
              # { title: "5014M-B01018" },
              # { title: "3557-A01440" },
              # { title: "3558-A01440" },
              # { title: "3559-A01445" },
              # { title: "3557G-A00651 #{@variable_pattern}" },
              # { title: "3558A-A651 #{@variable_pattern}" },
              # { title: "3559M-A00651 #{@variable_pattern}" },
              # { title: "3558E-A00651 #{@variable_pattern}" },
              # { title: "2516-3-507" }
            ]

            Models::SKU.bulk_create(skus)
          end

          def create_device_series_skus
            device_series_amount = Models::DeviceSeries.count
            skus = Models::SKU.map(&:id)

            (1..device_series_amount).to_a.shuffle.map do |device_series_id|
              skus_dup = skus.dup

              device_series_skus = (1..rand(1..3)).to_a.shuffle.map.with_index do |amount, layer|
                sku_id = skus_dup.sample
                skus_dup -= [sku_id]

                {
                  device_series_id: device_series_id,
                  sku_id: sku_id,
                  amount: amount,
                  layer: layer + 1,
                  unit_price: rand(1..100.0)
                }
              end

              Models::DeviceSeriesSKU.bulk_create(device_series_skus)
            end
          end

          def create_parameters
            skus = Models::SKU.all(:title.like => "%#{@variable_pattern}%")
            device_series_skus = Models::DeviceSeriesSKU.all(sku: { :title.like => "%#{@variable_pattern}%" })

            variables = %w(X Y)
            descriptions = %w(Цвет Форма)

            device_series_skus.each do |device_series_sku|
              variable = "#{variables.sample}#{rand(1..2)}"
              description = descriptions.sample

              title = device_series_sku.sku.title.sub(@variable_pattern, variable)
              device_series_sku.sku.update(title: title)

              device_series_sku.device_series.parameters.first_or_create({ variable: variable }, { description: description })
              device_series_sku.update(unit_price: 0.0)
            end
          end

          def create_values
            parameters_amount = Models::Parameter.count

            value_hashes = [
              { code: '280', description: 'Анрацит' },
              { code: '281', description: 'Слоновая кость' },
              { code: '284', description: 'Серебро' },
              { code: '286', description: 'Белый бархат' },
              # { code: '288', description: 'Белый' },
              # { code: '295', description: 'Бежевый' },
              # { code: '296', description: 'Серый' },
              # { code: '297', description: 'Бордовый' },
              # { code: '299', description: 'Голубой' },
              # { code: '84',  description: 'Кирпичный' },
              # { code: '896', description: 'Дымчатый' }
            ]

            (1..parameters_amount).to_a.shuffle.map do |parameter_id|
              values = value_hashes.sample(rand(1..value_hashes.size)).map.with_index do |value, index|
                {
                  parameter_id: parameter_id,
                  code:         value[:code],
                  description:  value[:description],
                  selected:     index == 0
                }
              end

              Models::Value.bulk_create(values)
            end
          end

          def create_sku_parameters
            device_series_skus_amount = Models::DeviceSeriesSKU.count
            parameters_amount = Models::Parameter.count

            (1..device_series_skus_amount).to_a.shuffle.map do |device_series_sku_id|
              values = (1..parameters_amount).to_a.shuffle.map do |parameter_id|
                {
                  device_series_sku_id: device_series_sku_id,
                  parameter_id:         parameter_id
                }
              end

              Models::SKUParameter.bulk_create(values)
            end
          end

          def create_sku_values
            sku_parameters_amount = Models::SKUParameter.count
            values_amount = Models::Value.count

            (1..sku_parameters_amount).to_a.shuffle.map do |sku_parameter_id|
              values = (1..values_amount).to_a.shuffle.map do |value_id|
                {
                  sku_parameter_id: sku_parameter_id,
                  value_id:         value_id,
                  unit_price:       rand(1..100.0)
                }
              end

              Models::SKUValue.bulk_create(values)
            end
          end

          def create_tags
            Models::Tag.bulk_create([
              { title: 'Классический дизайн' },
              { title: 'Натуральные материалы' }
            ])
          end

          def create_taggings
            tags_amount = Models::Tag.count
            device_series_amount = Models::DeviceSeries.count

            taggings = (1..device_series_amount).to_a.shuffle.map do |device_series|
              (1..tags_amount).to_a.shuffle.map do |tag|
                {
                  tag_id: tag,
                  device_series_id: device_series
                }
              end
            end.flatten

            Models::Tagging.bulk_create(taggings)
          end
      end
    end
  end
end