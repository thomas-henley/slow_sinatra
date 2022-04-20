require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"
require "date"

configure do
  set :port, 80
  set :lock, true
  set :version, "1.0.1"
end

def log(message)
  unless settings.test?
    puts message
  end
end

def get_delay(request)
  Time.now.to_i - request.env["HTTP_REQUEST_TIME"].to_i
end

get "/" do
  log "\n\n"
  sleep(0.2)

  delay = get_delay(request)

  log "\n#{Thread.current.object_id}: Sending response #{delay} seconds after request:"

  ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  "SlowSinatra - v#{settings.version} : Hello, I am #{ip.ip_address}. This request was received #{delay} seconds ago.\n"
end

get "/ping" do
  ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  "SlowSinatra - v#{settings.version} : pong from #{ip.ip_address}!\n"
end