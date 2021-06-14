# NOTES:
# * `Time.local` already returns the requested time format (cool!)
# * Nontrivial OptionParser boilerplate with respect to error handling.

require "http/server"
require "json"
require "log"
require "option_parser"

module HttpHello
  def respond_json(context, data)
    payload = data.to_json.to_slice
    context.response.content_length = payload.size
    context.response.content_type = "application/json; charset=utf-8"
    context.response.write payload
  end

  class Handler
    include HTTP::Handler

    @response_data = {
      "time" => Time.local(),
      "datum" => [
        "eAcute is \u{00E9}, combinedEAcute is \u{0065}\u{0301}; precomposed is \u{D55C}, decomposed is \u{1112}\u{1161}\u{11AB}",
        10000000,
        nil,
        [0, 0.0],
      ]
    }

    def initialize(@delay : Float64)
    end

    def call(context)
      sleep @delay
      respond_json(context, @response_data)
    end
  end

  class ServerOptions
    property delay
    def initialize(@delay = 0.25)
    end
  end

  def make_server(options)
    delay = options.delay

    if (delay < 0.0)
      raise ArgumentError.new("Delay cannot be negative")
    end

    if (delay > 5.0)
      raise ArgumentError.new("Delay is too long: #{delay}")
    end

    return HTTP::Server.new Handler.new(options.delay)
  end

  class CLI
    def die(status, msg)
      STDERR.puts msg
      exit status
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
      if delay.size() > 0
        begin
          options.delay = delay.to_f
        rescue e : ArgumentError
          die 1, "Invalid value for --delay: #{delay}."
        end
      end

      return options
    end

    def main
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

      puts "Listening for HTTP requests at #{address}, with request delay #{options.delay} seconds."
      server.listen
    end
  end
end

# TODO: I have no idea how to use modules. Scoping is so stupid and complicated in this language.
include HttpHello
CLI.new.main
