require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"
require "date"

configure do
  set :port, 80
  set :lock, true
  set :version, "0.0.6"
end

def log(message)
  unless settings.test?
    puts message
  end
end

def print_log(message)
  unless settings.test?
    print message
  end
end

def get_delay(request)
  Time.now.to_i - request.env["HTTP_REQUEST_TIME"].to_i
end

get "/" do
  log "\n\n"
  print_log "#{Thread.current.object_id}: Request received. Waiting"
  # 1.upto(1) do |i|
  #   print_log "..." unless settings.test?
  #   sleep(1)
  # end
  sleep(0.2)

  delay = get_delay(request)

  log "\nSending response #{delay} seconds after request:"

  ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  "SlowSinatra-v#{settings.version}: Hello, I am #{ip.ip_address}. This request was received #{delay} seconds ago.\n"
end

get "/ping" do
  ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  "SlowSinatra-v#{settings.version}: pong from #{ip.ip_address}!\n"
end