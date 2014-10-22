Rack::Test::Session.class_eval do
  def options(uri, params = {}, env = {}, &block)
    env = env_for(uri, env.merge(method: 'OPTIONS', params: params))
    process_request(uri, env, &block)
  end
end

Rack::Test::Methods.class_eval do
  def_delegator :current_session, :options
end

module RSpecCORSMixin
  include Rack::Test::Methods

  def app
    attr_accessor :cors_result

    test = self
    Rack::Builder.new do
      eval File.read(require File.expand_path '../../config.ru', __FILE__)
      map('/') do
        run proc { |env|
          test.cors_result = env[Rack::Cors::ENV_KEY]
          [200, {'Content-Type' => 'text/html'}, ['success']]
        }
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpecCORSMixin
end