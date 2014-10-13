Dir["#{File.dirname(__FILE__) }/../lib/models/*.rb"].each { |file| require file }

module OnOff
  module API
    module DB
      class SeedsLoader
        attr_accessor :variable_pattern

        def initialize
          @variable_pattern = '{{variable}}'

          DataMapper.finalize
          DataMapper.auto_migrate!
          DataMapper.auto_upgrade!

          create_device_groups

          create_devices
          create_series
          create_manufacturers

          create_device_series
          create_skus

          create_device_series_skus

          create_parameters
          create_values

          # create_sku_parameters

          # create_tags
          # create_taggings
        end

        private
          def create_device_groups
            Models::DeviceGroup.bulk_create([
              { title: 'Розетка' },
              { title: 'Выключатель' },
              { title: 'Диммер' },
              { title: 'Рамка' },
              { title: 'Опция 1' }
            ])
          end

          def create_devices
            device_groups = Models::DeviceGroup.all

            jacks           = device_groups.first(title: 'Розетка')
            switches        = device_groups.first(title: 'Выключатель')
            dimmers         = device_groups.first(title: 'Диммер')
            frames          = device_groups.first(title: 'Рамка')
            first_parameter = device_groups.first(title: 'Опция 1')

            Models::Device.bulk_create([
              { title: 'Розетка', device_group: jacks },
              { title: 'Розетка с крышкой',     device_group: jacks },
              { title: 'Выключатель 1 кл.',     device_group: switches },
              { title: 'Выключатель 2 кл.',     device_group: switches },
              { title: 'Розетка ТВ',            device_group: jacks },
              { title: 'Розетка ТВ+Спутник',    device_group: jacks },
              { title: 'Розетка компьютерная',  device_group: jacks },
              { title: 'Розетка телефонная',    device_group: jacks },
              { title: 'Диммер поворотный',     device_group: dimmers },
              { title: 'Рамка 1-ая',            device_group: frames },
              { title: 'Рамка 2-ая',            device_group: frames },
              { title: 'Рамка 3-ая',            device_group: frames },
              { title: 'Рамка 4-ая',            device_group: frames },
              { title: 'Рамка 5-ая',            device_group: frames },
              # { title: 'Декоративная накладка', device_group: first_parameter }
            ])
          end

          def create_series
            series = Models::Series.bulk_create([
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
            manufacturers = Models::Manufacturer.bulk_create([
              { assembly: 'Busch Jaeger', title: 'ABB', country: 'Германия' }
            ])
          end

          def create_device_series
            devices_amount = Models::Device.count
            series_amount = Models::Series.count
            manufacturers_amount = Models::Manufacturer.count

            device_series = (1..devices_amount).to_a.shuffle.map do |device_id|
              (1..series_amount).to_a.shuffle.map do |series_id|
                device_series = (1..manufacturers_amount).to_a.shuffle.map do |manufacturer_id|
                  {
                    device_id:        device_id,
                    series_id:        series_id,
                    manufacturer_id:  manufacturer_id
                  }
                end

                Models::DeviceSeries.bulk_create(device_series)
              end
            end
          end

          def create_skus
            skus = [
              { title: "8150", unit_price: rand(1..100.0) },
              { title: "5550 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "0209-507", unit_price: rand(1..100.0) },
              { title: "N2288.1 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "N2271.9", unit_price: rand(1..100.0) },
              { title: "0213-507", unit_price: rand(1..100.0) },
              { title: "1803-#{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "2006/6 UC-#{@variable_pattern}-507", unit_price: rand(1..100.0) },
              { title: "2000/6 US", unit_price: rand(1..100.0) },
              { title: "2001/6 U-507  ", unit_price: rand(1..100.0) },
              { title: "2000/6 US-507", unit_price: rand(1..100.0) },
              { title: "2506-#{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "1786-#{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "2006/1 UCGL-#{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "2000/1 US", unit_price: rand(1..100.0) },
              { title: "2001/6 U-507", unit_price: rand(1..100.0) },
              { title: "2000/1 US-500", unit_price: rand(1..100.0) },
              { title: "2509-#{@variable_pattern}-500", unit_price: rand(1..100.0) },
              { title: "1789-#{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "1786-#{@variable_pattern}-507", unit_price: rand(1..100.0) },
              { title: "1721-#{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "3916-12221", unit_price: rand(1..100.0) },
              { title: "5518G-A03449 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "5518A-A3449 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "5518M-A03459 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "5518E-A03459 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "1228.01 RJ 12-6", unit_price: rand(1..100.0) },
              { title: "5013U-A01105", unit_price: rand(1..100.0) },
              { title: "5014G-A01018 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "5013A-A00215 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "5014M-A00100 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "5013E-A00215 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "5014M-B01018", unit_price: rand(1..100.0) },
              { title: "3557-A01440", unit_price: rand(1..100.0) },
              { title: "3558-A01440", unit_price: rand(1..100.0) },
              { title: "3559-A01445", unit_price: rand(1..100.0) },
              { title: "3557G-A00651 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "3558A-A651 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "3559M-A00651 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "3558E-A00651 #{@variable_pattern}", unit_price: rand(1..100.0) },
              { title: "2516-3-507", unit_price: rand(1..100.0) }
            ]

            Models::SKU.bulk_create(skus)
          end

          def create_device_series_skus
            device_series_amount = Models::DeviceSeries.count
            skus = Models::SKU.all(fields: [ :id ]).map(&:id)

            (1..device_series_amount).to_a.shuffle.map do |device_series_id|
              skus_dup = skus.dup

              device_series_skus = (1..rand(1..4)).to_a.shuffle.map do |amount|
                sku_id = skus_dup.sample
                skus_dup -= [sku_id]

                {
                  device_series_id: device_series_id,
                  sku_id: sku_id,
                  amount: amount
                }
              end

              Models::DeviceSeriesSKU.bulk_create(device_series_skus)
            end
          end

          def create_parameters
            skus = Models::SKU.all(:title.like => "%#{@variable_pattern}%")

            variables = ('X'..'Z').to_a
            descriptions = %w(Цвет Форма Вкус Запах)
            skus.map do |sku|
              variable = "#{variables.sample}#{rand(1..3)}"
              title = sku.title.sub(@variable_pattern, variable)
              sku.update(title: title)

              description = descriptions.sample
              sku.device_series_skus.map do |device_series_sku|
                device_series_sku.parameters.first_or_create({ variable: variable }, { description: description })
              end

              sku.parameters
            end
          end

          def create_values
            parameters_amount = Models::Parameter.count

            value_hashes = [
              { code: '280', description: 'Анрацит' },
              { code: '281', description: 'Слоновая кость' },
              { code: '284', description: 'Серебро' },
              { code: '285', description: 'Белый' },
              { code: '286', description: 'Белый бархат' },
              { code: '287', description: 'Белый бархат' },
              { code: '288', description: 'Белый' },
              { code: '291', description: 'Слоновая кость' },
              { code: '295', description: 'Бежевый' },
              { code: '296', description: 'Серый' },
              { code: '297', description: 'Бордовый' },
              { code: '299', description: 'Голубой' },
              { code: '84',  description: 'Кирпичный' },
              { code: '896', description: 'Дымчатый' }
            ]

            (1..parameters_amount).to_a.shuffle.map do |parameter_id|
              values = value_hashes.sample(rand(1..value_hashes.size)).map do |value|
                {
                  parameter_id: parameter_id,
                  code: value[:code],
                  description: value[:description]
                }
              end

              Models::Value.bulk_create(values)
            end
          end

          def create_sku_parameters
            skus_amount = Models::DeviceSeriesSKU.count
            parameters_amount = Models::Parameter.count

            (1..skus_amount).to_a.shuffle.map do |sku|
              sku_parameters = (1..parameters_amount).to_a.shuffle.map do |parameter|
                {
                  sku_id: sku,
                  parameter_id: parameter
                }
              end

              Models::SKUParameter.bulk_create(sku_parameters)
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