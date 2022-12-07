require 'socket'
require 'date'
require './http_response'
require 'CGI'
class ServerThread
  def initialize(socket)
    @socket = socket
  end

  def run
    while (line = @socket.gets) != "\r\n"
      path = line.split(' ')[1] if line&.start_with?('GET')
    end

    decoded_path = CGI.unescape(path)
    decoded_path_to_file = File.join(Util::BASE_DIR, decoded_path)

    return HTTPResponse.send_not_found(@socket) unless Util.valid_path?(decoded_path)

    if File.directory?(decoded_path_to_file)
      path_to_file = File.join(decoded_path, 'index.html')
      location = "http://localhost:3030#{decoded_path_to_file}"
      HttpResponse.send_moved_permanently(@socket, location)
    elsif File.exist?(decoded_path_to_file)
      HttpResponse.send_ok(@socket, decoded_path_to_file)
    else
      HttpResponse.send_not_found(@socket)
    end
  rescue StandardError => e
    puts e
  ensure
    @socket.close
  end
end
