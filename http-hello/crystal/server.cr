# NOTES:
# * `Time.local` already returns the requested time format (cool!)
# * Nontrivial OptionParser boilerplate.


require "http/server"
require "json"
require "log"
require "option_parser"


def die(status, msg)
  STDERR.puts msg
  exit status
end


class Handler
  include HTTP::Handler

  def initialize(@delay : Float64)
  end

  def call(context)
    sleep @delay
    response_data = {
      "time" => Time.local(),
      "datum" => [
        "eAcute is é, combinedEAcute is é; precomposed is 한, decomposed is 한",
        10000000,
        nil,
        [0, 0.0],
      ]
    }
    payload = response_data.to_json.to_slice
    context.response.content_length = payload.size
    context.response.content_type = "application/json; charset=utf-8"
    context.response.write payload
  end
end


class ServerOptions
  property delay
  def initialize(@delay = 0.25)
  end
end


def make_server(options)
  delay = options.delay
  if (delay < 0.0) | (delay > 5.0)
    raise ArgumentError.new("Invalid delay: #{delay}.")
  end

  return HTTP::Server.new Handler.new(options.delay)
end


def parse_cli
  if ENV.has_key? "HELLO_DELAY"
    delay = ENV["HELLO_DELAY"]
  else
    delay = ""
  end

  OptionParser.parse do |parser|
    parser.banner = "Polyglot - HTTP Hello"

    parser.on "-h", "--help", "Show help and exit." do
      puts parser
      exit
    end

    parser.on "-v", "--version", "Show version and exit." do
      puts "v1.0"
      exit
    end

    parser.missing_option do |option_flag|
      die 1, "ERROR: #{option_flag} requires an argument."
    end

    parser.invalid_option do |option_flag|
      die 1, "ERROR: #{option_flag} is not a valid option."
    end

    parser.on "--delay=VALUE", "Request-handling delay." do |value|
      delay = value
    end
  end

  options = ServerOptions.new
  begin
    options.delay = delay.to_f
  rescue e : ArgumentError
    die 1, "Invalid delay value: #{delay}."
  end

  return options
end


options = parse_cli

begin
  server = make_server(options)
rescue e : ArgumentError
  die 1, e
end

begin
	address = server.bind_tcp ARGV[0].to_i
rescue e : IndexError
	die 1, "No port number provided."
end

puts "Listening on http://#{address}, with request delay #{options.delay} seconds."
server.listen

