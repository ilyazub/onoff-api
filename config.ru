require './lib/onoff'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins 'localhost:9000', '127.0.0.1:9000'
    resource '*', headers: :'*', methods: :get
  end
end

run OnOff::API::Main