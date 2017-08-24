require_relative './conf/init'

server = WEBrick::HTTPServer.new Port: 8000




# Routing

Routing.route({
                root: 'main#index',

                countries: 'countries#index'
=begin
  regions: 'regions#index',
                cities: 'cities#index'
=end
              }, server)




=begin



server.mount_proc '/regions' do |req, res|
  result = ''
  params = req.query
  countries = Country.load!('./world/data/')
  country = countries.find {|c| c.cid.to_s == params['country_id']}

  regions = country.regions
  res.body = TEMPLATES[:regions].result(binding)
end
=end




server.start
