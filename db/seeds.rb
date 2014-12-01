Dir["#{File.dirname(__FILE__) }/../lib/models/*.rb"].each { |f| require f }

module OnOff
  module API
    module DB
      class SeedsLoader
        attr_accessor :variable_pattern

        def initialize
          DataMapper.finalize

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
        end

        private
          def create_everything
            Models::Manufacturer.bulk_create([
              { title: 'ABB', country: 'Германия' }
            ])

            Models::Manufacturer.first(title: 'ABB').series.bulk_create([
              { title: 'Basic 55' },
              { title: 'Reflex' },
              { title: 'Busch-Duro' },
              { title: 'Spring' },
              { title: 'Alpha' },
              { title: 'Alpha Exclusive' },
              { title: 'Future/Future Linear' },
              { title: 'Solo' },
              { title: 'Axcent' },
              { title: 'Impuls' },
              { title: 'Pure Steel' },
              { title: 'Carat ' }
            ])

            Models::DeviceGroup.bulk_create([
              { title: 'Устройство' },
              { title: 'Рамка' }
            ])

            Models::DeviceGroup.first(title: 'Устройство').devices.bulk_create([
              { title: 'Розетка с заземлением' },
              { title: 'Розетка с заз.и крышкой' },
              { title: 'Розетка TV' },
              { title: 'Розетка TV+R' },
              { title: 'Розетка TF' },
              { title: 'Розетка TF двойная' },
              { title: 'Розетка компьютер н/э' },
              { title: 'Выключатель 1-кл.' },
              { title: 'Выключатель 1-кл.прох.' },
              { title: 'Выключатель 2-кл.' },
              { title: 'Выключатель 2-кл.прох.' },
              { title: 'Выключатель 1-кл. подсв.' },
              { title: 'Диммер повор. 400Вт' },
              { title: 'Диммер повор. 600Вт' },
              { title: 'Диммер сенсорный 500Вт' },
              { title: 'Датчик дв./комф.выкл.' },
              { title: 'Датчик движения Комфорт' }
            ])

            Models::DeviceGroup.first(title: 'Рамка').devices.bulk_create([
              { title: 'Рамка 1 пост' },
              { title: 'Рамка 2 поста' },
              { title: 'Рамка 3 поста' },
              { title: 'Рамка 4 поста' },
              { title: 'Рамка 5 постов' }
            ])
          end

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
              { title: 'Выключатель 2 кл.',     device_group: switches },
              { title: 'Диммер поворотный',     device_group: dimmers }
            ])
          end

          def create_manufacturers
            Models::Manufacturer.bulk_create([
              { title: 'ABB', country: 'Германия' }
            ])
          end

          def create_series
            manufacturer = Models::Manufacturer.first

            Models::Series.bulk_create([
              { title: 'Basic 55', manufacturer: manufacturer },
              { title: 'Solo', manufacturer: manufacturer },
              { title: 'Axcent', manufacturer: manufacturer },
              { title: 'Carat', manufacturer: manufacturer }
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
              { title: "1803-#{@variable_pattern}" }
            ]

            Models::SKU.bulk_create(skus)
          end

          def create_device_series_skus
            device_series_amount = Models::DeviceSeries.count
            skus = Models::SKU.map(&:id)

            (1..device_series_amount).to_a.shuffle.map do |device_series_id|
              skus_dup = skus.dup

              device_series_skus = (1..rand(1..3)).to_a.shuffle.map do |amount|
                sku_id = skus_dup.sample
                skus_dup -= [sku_id]

                {
                  device_series_id: device_series_id,
                  sku_id: sku_id,
                  amount: amount,
                  unit_price: rand(1..100.0)
                }
              end

              Models::DeviceSeriesSKU.bulk_create(device_series_skus)
            end
          end

          def create_parameters
            series = Models::Series.all({
              device_series: {
                device_series_skus: {
                  sku: { :title.like => "%#{@variable_pattern}%" }
                }
              }
            })

            variables = %w(X Y)
            descriptions = %w(Цвет Форма)

            variables.each_with_index do |var, index|
              variable = "#{var}#{index + 1}"
              description = descriptions.at(index)
              series.each do |serie|
                serie.parameters.first_or_create({ variable: variable }, { description: description })

                serie.device_series_skus.all(sku: { :title.like => "%#{@variable_pattern}%" }).each do |device_series_sku|
                  title = device_series_sku.sku.title.sub(@variable_pattern, variable)
                  device_series_sku.sku.update(title: title)
                  device_series_sku.update(unit_price: 0.0)
                end
              end
            end
          end

          def create_values
            parameters = Models::Parameter.all

            value_hashes = [
              { code: '280', description: 'Анрацит' },
              { code: '281', description: 'Слоновая кость' },
              { code: '284', description: 'Серебро' },
              { code: '286', description: 'Белый бархат' },
            ]

            parameters.shuffle.map do |parameter|
              values = value_hashes.map.with_index do |value, index|
                {
                  parameter_id: parameter.id,
                  code:         value[:code],
                  description:  value[:description],
                  selected:     index == 0
                }
              end

              Models::Value.bulk_create(values)
            end
          end

          def create_sku_parameters
            device_series_skus = Models::DeviceSeriesSKU.all(unit_price: 0.0)

            device_series_skus.shuffle.map do |device_series_sku|
              parameters = Models::Parameter.all(series: { device_series: { device_series_skus: { id: device_series_sku.id } } })

              parameters = parameters.shuffle.map do |parameter|
                {
                  device_series_sku_id: device_series_sku.id,
                  parameter_id:         parameter.id
                }
              end

              Models::SKUParameter.bulk_create(parameters)
            end
          end

          def create_sku_values
            sku_parameters = Models::SKUParameter.all

            sku_parameters.shuffle.map do |sku_parameter|
              values = Models::Value.all(parameter_id: sku_parameter.parameter_id)

              sku_values = values.shuffle.map do |value|
                {
                  sku_parameter_id: sku_parameter.id,
                  value_id:         value.id,
                  unit_price:       rand(1..100.0)
                }
              end

              Models::SKUValue.bulk_create(sku_values)
            end
          end
      end
    end
  end
end