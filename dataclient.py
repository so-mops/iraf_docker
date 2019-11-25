#!/usr/bin/env python2

import socket

HOST = 'localhost'  # The server's hostname or IP address
PORT = 6540        # The port used by the server

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))
s.settimeout(None) #blocking
data = None
while True:
    try:
        data = s.recv(1024)
        if data == '':
            break
    except KeyboardInterrupt as err:
        break

s.shutdown(1)
s.close()
