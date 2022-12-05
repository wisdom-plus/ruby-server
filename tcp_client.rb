require 'socket'

socket = TCPSocket.new('localhost', 3030)

# client_send.txtの内容を一行ずつ書き込む
File.foreach('client_send.txt') do |file_line|
  socket.write(file_line)
end

# 書き込み終了の合図として0を書き込む
socket.write('0')

File.open('client_recv.txt', 'w') do |file|
  while ch = socket.read(1)
    file.write(ch)
  end
end
