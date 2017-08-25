require_relative './conf/init'



server = WEBrick::HTTPServer.new(Port: SERVER_CONFIG['port'])

Routing.route({
                guests: 'guests#index'
              }, server)

server.start
