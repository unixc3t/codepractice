require_relative './conf/init'
require 'sinatra'


Routing.route({
                'guests#index' => { path: %w(/ /guests), methods: [:get] },
                'guests#create' => { path: '/guests', methods: [:post] },
                'contacts#us' => { path: %w(/contacts /contacts_us /about_us), methods: :get},
                'guests#api' => { path: '/api', methods: %w(get post)}
              }, binding)


