require 'socket'
require 'date'
require './http_response'

class ServerThread
  def initialize(socket)
    @socket = socket
  end

  def run
    while (line = @socket.gets) != "\r\n"
      path = line.split(' ')[1] if line&.start_with?('GET')
    end

    path_to_file = File.join(Util::BASE_DIR, path)

    return HTTPResponse.send_not_found(@socket) unless Util.is_valid_path?(path_to_file)

    if File.exist?(path_to_file)
      HttpResponse.send_ok(@socket, path_to_file)
    else
      HttpResponse.send_not_found(@socket)
    end
  rescue StandardError => e
    puts e
  ensure
    @socket.close
  end
end
