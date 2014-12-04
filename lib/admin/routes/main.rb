require_relative '../../parser/catalogue'
require_relative '../../parser/prices'

require 'RMagick'

module OnOff
  module API
    module Routes
      module Admin
        class Main < Grape::API
          helpers do
            def import(spreadsheet_type, parser)
              return if params[spreadsheet_type].nil?

              extension = File.extname(params[spreadsheet_type][:filename])
              options = { extension: extension }

              parser.parse(params[spreadsheet_type][:tempfile].path.to_s, options)
            end

            def process_image(type)
              return if params[type].nil?

              file = params[type]
              image = Magick::Image.read(file[:tempfile].path).first

              filename      = File.basename(file[:filename], File.extname(file[:filename])).downcase
              new_filename  = File.join(OnOff::API.application.images_folder, "#{filename}.jpg")

              devices = OnOff::API::Models::Device.all(conditions: [ "lower(code) = ?", filename ])
              series  = OnOff::API::Models::Series.all(conditions: [ "lower(title) = ?", filename ])
              values  = OnOff::API::Models::SKUValue.all(conditions: [ "lower(compiled_title) = ?", filename.gsub(/(_)/, '/') ]).values

              if devices.size > 0
                image.trim!
                image.resize_to_fit!(128, 32)
                image.write(new_filename) { self.quality = 80 }
              elsif series.size > 0
                image.trim!
                process_thumb(image, filename)
                image.resize_to_fit!(230)
                image.write(new_filename) { self.quality = 80 }
              elsif values.size > 0
                image.trim!
                image.resize_to_fit!(56)
                values.update(image_url: filename)
                image.write(new_filename) { self.quality = 80 }
              end
            end

            def process_thumb(image, filename)
              thumb = image.resize_to_fit(150)
              thumb_filename  = File.join(OnOff::API.application.images_folder, "#{filename}_thumb.jpg")

              thumb.write(thumb_filename) { self.quality = 80 }
            end
          end

          resource :upload do
            params do
              optional :catalogue,  type: Rack::Multipart::UploadedFile
              optional :price_list, type: Rack::Multipart::UploadedFile
              optional :clear_db,   type: Boolean
            end
            post do
              DataMapper.finalize.auto_migrate!.auto_upgrade! if params[:clear_db]
              import(:catalogue, OnOff::API::Parser::Catalogue.new)
              import(:price_list, OnOff::API::Parser::Prices.new)
            end

            params do
              optional :image, type: Rack::Multipart::UploadedFile
            end
            post :images do
              process_image(:image)
            end
          end
        end
      end
    end
  end
end