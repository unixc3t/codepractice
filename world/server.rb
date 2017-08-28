require_relative './conf/init'
require 'sinatra'


Routing.route({
                'guests#index' => { path: ['/', '/guests'], methods: [:get] },
                'guests#create' => { path: '/guests', methods: [:post] }
              }, binding)


