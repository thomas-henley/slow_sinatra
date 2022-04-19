require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

after do
  1.upto(5) do |i|
    sleep(1)
    puts "#{Thread.current.object_id}: #{i}"
  end
end

get "/" do
  "Hello, I am thread #{Thread.current.object_id}.\n"
end