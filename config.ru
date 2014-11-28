require './lib/onoff'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
  end
end

# use Rack::CommonLogger, OnOff::API.application.logfile

use Rack::Deflater

run OnOff::API::Routes::Main