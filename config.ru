require './app'
$stdout.sync = true

run Rack::URLMap.new('/' => CheckApp)