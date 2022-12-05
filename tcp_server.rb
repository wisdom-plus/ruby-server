require 'socket'

begin
  server = TCPServer.open(3030)
  puts 'クライアントの接続を受け付けています'
  socket = server.accept
  puts 'クライアント接続'

  File.open('server_recv.txt', 'w') do |file|
    while (line = socket.gets) != "\r\n"
      file.write(line)
    end
  end

  File.foreach('server_send.txt') do |line|
    socket.write(line)
  end
rescue StandardError => e
  puts e
ensure
  socket.close
  server.close
end
