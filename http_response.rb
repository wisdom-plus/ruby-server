require './util'

module HttpResponse
  PATH_TO_NOT_FOUND = 'src/404.html'.freeze
  SERVER_NAME = 'RubySimpleServer'.freeze

  class << self
    def send_ok(socket, path)
      ext = Util.ext(path)&.to_sym
      socket.write("HTTP/1.1 200 OK\n")
      socket.write("Date: #{Util.utc_date_string}\n")
      socket.write("Server: #{SERVER_NAME}\n")
      socket.write("Connection: close\n")
      socket.write("Content-type: #{Util.content_type(ext)}\n")
      socket.write("\r\n")
      write_body(socket, path)
    end

    def send_not_found(socket)
      socket.write("HTTP/1.1 404 Not Found\n")
      socket.write("Date: #{Util.utc_date_string}\n")
      socket.write("Server: #{SERVER_NAME}\n")
      socket.write("Connection: close\n")
      socket.write("Content-type: text/html\n")
      socket.write("\r\n")
      write_body(socket, PATH_TO_NOT_FOUND)
    end

    private

    def write_body(socket, path)
      File.foreach(path) do |line|
        socket.write(line)
      end
    end
  end
end
