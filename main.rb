require 'socket'
require 'date'

server = TCPServer.open(3030)

begin
  socket = server.accept

  while (line = socket.gets) != "\r\n"
    path = line.split(' ')[1] if line&.start_with?('GET')
  end

  utc_date_string = DateTime.now.new_offset.strftime('%a, %d, %b, %Y, %H:%M:%S %Z GMT')

  socket.write("HTTP/1.1 OK\n")
  socket.write("Date: #{utc_date_string}\n")
  socket.write("Server: RubySimpleServer\n")
  socket.write("Connection: close\n")
  socket.write("Content-type: text/html\n")

  socket.write("\r\n")

  File.foreach("src/#{path}") do |line|
    socket.write(line)
  end
rescue StandardError => e
  puts e
ensure
  socket.close
  server.close
end
