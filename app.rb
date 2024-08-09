require 'sinatra'
require 'pg'
require 'json'
require 'redis'

class CheckApp < Sinatra::Base
  get '/' do
    content_type :json
    {
      message: 'Welcome to the Sinatra App!',
      routes: {
        check_db: '/check/db',
        check_redis: '/check/redis'
      }
    }.to_json
  end

  get '/check' do
    content_type :json
    {
      message: 'Welcome to the Sinatra App!',
      routes: {
        check_db: '/check/db',
        check_redis: '/check/redis'
      }
    }.to_json
  end

  get '/check/db' do
    begin
      connection = PG.connect(
        dbname: ENV['POSTGRESQL_DATABASE'],
        user: ENV['POSTGRESQL_USERNAME'],
        password: ENV['POSTGRESQL_PASSWORD'],
        host: ENV['POSTGRESQL_ADDRESS'],
        port: ENV['POSTGRESQL_PORT'] || 5432,
        connect_timeout: ENV['POSTGRESQL_TIMEOUT'] || 5
      )
      connection.exec("SELECT 1")
      connection.close
      status 200
      content_type :json
      { status: 'success', message: 'Connection to PostgreSQL is successful' }.to_json
    rescue PG::Error => e
      status 500
      content_type :json
      error_response = { status: 'error', message: e.message }
      error_response[:env] = ENV.to_hash if params['secret'] == ENV['ENV_SECRET']
      error_response.to_json
    end
  end

  get '/check/redis' do
    begin
      redis = Redis.new(url: ENV['REDIS_URL'])
      redis.ping
      status 200
      content_type :json
      { status: 'success', message: 'Connection to Redis is successful' }.to_json
    rescue Redis::BaseError => e
      status 500
      content_type :json
      error_response = { status: 'error', message: e.message }
      error_response[:env] = ENV.to_hash if params['secret'] == ENV['ENV_SECRET']
      error_response.to_json
    end
  end

  run! if app_file == $0
end