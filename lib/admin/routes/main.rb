require_relative '../entities/device_group'
require_relative '../entities/range'

require_relative '../../parser/catalogue'
require_relative '../../parser/prices'

module OnOff
  module API
    module Routes
      module Admin
        class Main < Grape::API
          resource :upload do
            params do
              requires :catalogue, type: Rack::Multipart::UploadedFile
            end
            post 'catalogue' do
              options = { extension: File.extname(params[:catalogue][:filename]) }
              parser = OnOff::API::Parser::Catalogue.new
              parser.parse(params[:catalogue][:tempfile].path.to_s, options)
            end

            params do
              requires :price_list, type: Rack::Multipart::UploadedFile
            end
            post 'price_list' do
              options = { extension: File.extname(params[:price_list][:filename]) }
              parser = OnOff::API::Parser::Prices.new
              parser.parse(params[:price_list][:tempfile].path.to_s, options)
            end
          end
        end
      end
    end
  end
end