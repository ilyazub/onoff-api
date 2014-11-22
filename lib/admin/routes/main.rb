require_relative '../../parser/catalogue'
require_relative '../../parser/prices'

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
          end

          resource :upload do
            params do
              optional :catalogue,  type: Rack::Multipart::UploadedFile
              optional :price_list, type: Rack::Multipart::UploadedFile
              optional :clear_db,   type: Boolean
            end
            post do
              DataMapper.auto_migrate! if params[:clear_db]
              import(:catalogue, OnOff::API::Parser::Catalogue.new)
              import(:price_list, OnOff::API::Parser::Prices.new)
            end
          end
        end
      end
    end
  end
end