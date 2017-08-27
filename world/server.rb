require_relative './conf/init'



server = WEBrick::HTTPServer.new(Port: SERVER_CONFIG['port'])

Routing.route({
                root: 'guests#index',
                guests: 'guests#index',
                create_message: 'guests#create'
              }, server)

server.start
