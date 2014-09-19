require_relative '../lib/models/device'
require_relative '../lib/models/cart_item'

module OnOff
  module API
    module DB
      class SeedsLoader
        def initialize
          DataMapper.finalize
          DataMapper.auto_migrate!
          DataMapper.auto_upgrade!

          device_groups = create_device_groups
          create_devices(device_groups)
        end

        private
          def create_device_groups
            Models::DeviceGroup.create_all([
              { title: 'Розетка' },
              { title: 'Выключатель' },
              { title: 'Диммер' },
              { title: 'Рамка' }
            ])
          end

          def create_devices(device_groups)
            jacks     = device_groups.first(title: 'Розетка')
            switches  = device_groups.first(title: 'Выключатель')
            dimmers   = device_groups.first(title: 'Диммер')
            frames    = device_groups.first(title: 'Рамка')

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
              { title: 'Рамка 5-ая', device_group: frames }
            ])
          end

        # manufacturers = Manufacturer.create([
        #   { title: 'EPJ', assembly: 'Мотор Сич', country: 'Украина' },
        #   { title: 'Busch Jaeger', assembly: 'ABB', country: 'Германия' },
        #   { title: 'NIE', assembly: 'Moeller', country: 'Германия' }
        # ])

        # options = Option.create([
        #   { title: 'Цвет' }
        # ])

        # series = Series.create([
        #   { title: 'Swing' },
        #   { title: 'Tango' },
        #   { title: 'Element' },
        #   { title: 'Neo' },
        #   { title: 'Time' },
        #   { title: 'Time Arbo' },
        #   { title: 'Basic 55' },
        #   { title: 'Busch-Duro Reflex' },
        #   { title: 'Spring' },
        #   { title: 'Alpha' },
        #   { title: 'Future Linear' },
        #   { title: 'Solo' },
        #   { title: 'Axcent' },
        #   { title: 'Impuls' },
        #   { title: 'Steel' },
        #   { title: 'Tacto' },
        #   { title: 'Zenit' }
        # ])

        # stock_keeping_units = StockKeepingUnit.create([
        #   { title: '8150', price: rand(1..100.0) },
        #   { title: '5550 X', price: rand(1..100.0) },
        #   { title: '0209-507', price: rand(1..100.0) },
        #   { title: 'N2288.1 X', price: rand(1..100.0) },
        #   { title: 'N2271.9', price: rand(1..100.0) },
        #   { title: '0213-507', price: rand(1..100.0) },
        #   { title: '1803-X', price: rand(1..100.0) },
        #   { title: '2006/6 UC-X-507', price: rand(1..100.0) },
        #   { title: '2000/6 US', price: rand(1..100.0) },
        #   { title: '2001/6 U-507  ', price: rand(1..100.0) },
        #   { title: '2000/6 US-507', price: rand(1..100.0) },
        #   { title: '2506-X-507', price: rand(1..100.0) },
        #   { title: '1786-X', price: rand(1..100.0) },
        #   { title: '2006/1 UCGL-X-507', price: rand(1..100.0) },
        #   { title: '2000/1 US', price: rand(1..100.0) },
        #   { title: '2001/6 U-507', price: rand(1..100.0) },
        #   { title: '2000/1 US-500', price: rand(1..100.0) },
        #   { title: '2509-X-500', price: rand(1..100.0) },
        #   { title: '1789-X', price: rand(1..100.0) },
        #   { title: '1786-X-507', price: rand(1..100.0) },
        #   { title: '3916-12221', price: rand(1..100.0) },
        #   { title: '5518G-A03449 X', price: rand(1..100.0) },
        #   { title: '5518A-A3449 X', price: rand(1..100.0) },
        #   { title: '5518M-A03459 X', price: rand(1..100.0) },
        #   { title: '5518E-A03459 X', price: rand(1..100.0) },
        #   { title: '1228.01 RJ 12-6', price: rand(1..100.0) },
        #   { title: '5013U-A01105', price: rand(1..100.0) },
        #   { title: '5014G-A01018 X', price: rand(1..100.0) },
        #   { title: '5013A-A00215 X', price: rand(1..100.0) },
        #   { title: '5014M-A00100 X', price: rand(1..100.0) },
        #   { title: '5013E-A00215 X', price: rand(1..100.0) },
        #   { title: '5014M-B01018  ', price: rand(1..100.0) },
        #   { title: '3557-A01440', price: rand(1..100.0) },
        #   { title: '3558-A01440', price: rand(1..100.0) },
        #   { title: '3559-A01445', price: rand(1..100.0) },
        #   { title: '3557G-A00651 X', price: rand(1..100.0) },
        #   { title: '3558A-A651 X', price: rand(1..100.0) },
        #   { title: '3559M-A00651 X', price: rand(1..100.0) },
        #   { title: '3558E-A00651 X', price: rand(1..100.0) }
        # ])

        # device_series = DeviceSeries.create([
        #   { device_id: 1, series_id: 1, manufacturer_id: 1 },
        #   { device_id: 1, series_id: 2, manufacturer_id: 1 },
        #   { device_id: 1, series_id: 3, manufacturer_id: 1 },
        #   { device_id: 1, series_id: 4, manufacturer_id: 1 },
        #   { device_id: 1, series_id: 5, manufacturer_id: 1 },
        #   { device_id: 1, series_id: 6, manufacturer_id: 1 },
        #   { device_id: 2, series_id: 1, manufacturer_id: 1 },
        #   { device_id: 2, series_id: 2, manufacturer_id: 1 },
        #   { device_id: 2, series_id: 3, manufacturer_id: 1 },
        #   { device_id: 2, series_id: 4, manufacturer_id: 1 },
        #   { device_id: 2, series_id: 5, manufacturer_id: 1 },
        #   { device_id: 2, series_id: 6, manufacturer_id: 1 },
        #   { device_id: 3, series_id: 1, manufacturer_id: 1 },
        #   { device_id: 3, series_id: 2, manufacturer_id: 1 },
        #   { device_id: 3, series_id: 3, manufacturer_id: 1 },
        #   { device_id: 3, series_id: 4, manufacturer_id: 1 },
        #   { device_id: 3, series_id: 5, manufacturer_id: 1 },
        #   { device_id: 3, series_id: 6, manufacturer_id: 1 },
        #   { device_id: 4, series_id: 1, manufacturer_id: 1 },
        #   { device_id: 4, series_id: 2, manufacturer_id: 1 },
        #   { device_id: 4, series_id: 3, manufacturer_id: 1 },
        #   { device_id: 4, series_id: 4, manufacturer_id: 1 },
        #   { device_id: 4, series_id: 5, manufacturer_id: 1 },
        #   { device_id: 4, series_id: 6, manufacturer_id: 1 },
        #   { device_id: 5, series_id: 1, manufacturer_id: 1 },
        #   { device_id: 5, series_id: 2, manufacturer_id: 1 },
        #   { device_id: 5, series_id: 3, manufacturer_id: 1 },
        #   { device_id: 5, series_id: 4, manufacturer_id: 1 },
        #   { device_id: 5, series_id: 5, manufacturer_id: 1 },
        #   { device_id: 5, series_id: 6, manufacturer_id: 1 },
        #   { device_id: 1, series_id: 7, manufacturer_id: 2 },
        #   { device_id: 1, series_id: 8, manufacturer_id: 2 },
        #   { device_id: 1, series_id: 9, manufacturer_id: 2 },
        #   { device_id: 1, series_id: 10, manufacturer_id: 2 },
        #   { device_id: 1, series_id: 11, manufacturer_id: 2 },
        #   { device_id: 1, series_id: 12, manufacturer_id: 2 },
        #   { device_id: 2, series_id: 7, manufacturer_id: 2 },
        #   { device_id: 2, series_id: 8, manufacturer_id: 2 },
        #   { device_id: 2, series_id: 9, manufacturer_id: 2 },
        #   { device_id: 2, series_id: 10, manufacturer_id: 2 },
        #   { device_id: 2, series_id: 11, manufacturer_id: 2 },
        #   { device_id: 2, series_id: 12, manufacturer_id: 2 },
        #   { device_id: 3, series_id: 7, manufacturer_id: 2 },
        #   { device_id: 3, series_id: 8, manufacturer_id: 2 },
        #   { device_id: 3, series_id: 9, manufacturer_id: 2 },
        #   { device_id: 3, series_id: 10, manufacturer_id: 2 },
        #   { device_id: 3, series_id: 11, manufacturer_id: 2 },
        #   { device_id: 3, series_id: 12, manufacturer_id: 2 },
        #   { device_id: 4, series_id: 7, manufacturer_id: 2 },
        #   { device_id: 4, series_id: 8, manufacturer_id: 2 },
        #   { device_id: 4, series_id: 9, manufacturer_id: 2 },
        #   { device_id: 4, series_id: 10, manufacturer_id: 2 },
        #   { device_id: 4, series_id: 11, manufacturer_id: 2 },
        #   { device_id: 4, series_id: 12, manufacturer_id: 2 },
        #   { device_id: 5, series_id: 7, manufacturer_id: 2 },
        #   { device_id: 5, series_id: 8, manufacturer_id: 2 },
        #   { device_id: 5, series_id: 9, manufacturer_id: 2 },
        #   { device_id: 5, series_id: 10, manufacturer_id: 2 },
        #   { device_id: 5, series_id: 11, manufacturer_id: 2 },
        #   { device_id: 5, series_id: 12, manufacturer_id: 2 },
        #   { device_id: 1, series_id: 13, manufacturer_id: 3 },
        #   { device_id: 9, series_id: 14, manufacturer_id: 3 },
        #   { device_id: 7, series_id: 15, manufacturer_id: 3 },
        #   { device_id: 13, series_id: 16, manufacturer_id: 3 },
        #   { device_id: 8, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 10, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 2, series_id: 13, manufacturer_id: 3 },
        #   { device_id: 10, series_id: 14, manufacturer_id: 3 },
        #   { device_id: 8, series_id: 15, manufacturer_id: 3 },
        #   { device_id: 14, series_id: 16, manufacturer_id: 3 },
        #   { device_id: 9, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 14, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 3, series_id: 13, manufacturer_id: 3 },
        #   { device_id: 3, series_id: 14, manufacturer_id: 3 },
        #   { device_id: 3, series_id: 15, manufacturer_id: 3 },
        #   { device_id: 3, series_id: 16, manufacturer_id: 3 },
        #   { device_id: 15, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 18, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 4, series_id: 13, manufacturer_id: 3 },
        #   { device_id: 4, series_id: 14, manufacturer_id: 3 },
        #   { device_id: 4, series_id: 15, manufacturer_id: 3 },
        #   { device_id: 4, series_id: 16, manufacturer_id: 3 },
        #   { device_id: 11, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 13, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 5, series_id: 13, manufacturer_id: 3 },
        #   { device_id: 5, series_id: 14, manufacturer_id: 3 },
        #   { device_id: 5, series_id: 15, manufacturer_id: 3 },
        #   { device_id: 5, series_id: 16, manufacturer_id: 3 },
        #   { device_id: 12, series_id: 17, manufacturer_id: 3 },
        #   { device_id: 19, series_id: 17, manufacturer_id: 3 }
        # ])

        # series_options = SeriesOption.create([
        #   { series_id: 5 , option_id: 1, value: '81', description: 'Анрацит' },
        #   { series_id: 5 , option_id: 1, value: '82', description: 'Слоновая кость' },
        #   { series_id: 5 , option_id: 1, value: '83', description: 'Серебро' },
        #   { series_id: 5 , option_id: 1, value: '84', description: 'Белый' },
        #   { series_id: 5 , option_id: 1, value: '884', description: 'Белый бархат' },

        #   { series_id: 2, option_id: 1, value: 'В', description: 'белый' },
        #   { series_id: 2, option_id: 1, value: 'С', description: 'слоновая кость' },
        #   { series_id: 2, option_id: 1, value: 'D', description: 'бежевый' },
        #   { series_id: 2, option_id: 1, value: 'S', description: 'серый' },
        #   { series_id: 2, option_id: 1, value: 'R', description: 'бордовый' },
        #   { series_id: 2, option_id: 1, value: 'M2', description: 'голубой' },
        #   { series_id: 2, option_id: 1, value: 'R2', description: 'кирпичный' },
        #   { series_id: 2, option_id: 1, value: 'S2', description: 'дымчатый' },
        #   { series_id: 2, option_id: 1, value: 'H', description: 'табако' },
        #   { series_id: 2, option_id: 1, value: 'N', description: 'черный' }
        # ])

        # device_skus = DeviceSku.create([
        #   { device_series_id: 65, stock_keeping_units_id: 3, amount: 2 },
        #   { device_series_id: 65, stock_keeping_units_id: 22, amount: 2 },
        #   { device_series_id: 65, stock_keeping_units_id: 4, amount: 1 },
        #   { device_series_id: 65, stock_keeping_units_id: 5, amount: 1 }
        # ])
      end
    end
  end
end