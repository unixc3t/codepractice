require_relative './conf/init'

server = WEBrick::HTTPServer.new Port: 8000

Routing.route({
                root: 'main#index',
                countries: 'countries#index',
                regions: 'regions#index'
              }, server)

server.start
