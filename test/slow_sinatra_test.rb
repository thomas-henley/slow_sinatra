ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../slow"

class SlowSinatraTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_root
    get "/"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "I am thread"
  end

  def test_get_ping
    get "/ping"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "pong!"
  end

  def test_get_bad_endpoint
    get "/test"

    assert_equal 200, last_response.status
  end
end