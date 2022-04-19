require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "date"

set :port, 80
set :lock, true

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
  1.upto(5) do |i|
    print_log "." unless settings.test?
    sleep(1)
  end

  delay = get_delay(request)

  log "\nSending response #{delay} seconds after request:"

  "SlowSinatra-v0.0.4: Hello, I am thread #{Thread.current.object_id}. This request was received #{delay} seconds ago.\n"
end

get "/ping" do
  "SlowSinatra-v0.0.4: pong!\n"
end