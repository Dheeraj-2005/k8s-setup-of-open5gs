import http.server
import ssl

server_address = ('', 8443)
httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(certfile="server.pem", keyfile="server.pem")

httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

print("Serving on https://localhost:8443")
httpd.serve_forever()
