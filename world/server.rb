require_relative './conf/init'
require 'sinatra'
enable :sessions


Routing.route({
                'guests#index' => { path: %w(/ /guests), methods: [:get] },
                'guests#new' => { path: '/guests/new', methods: [:get] },
                'guests#create' => { path: '/guests', methods: [:post] },
                'guests#update' => { path: '/guests/:id/update', methods: [:post] },
                'guests#destroy' => { path: '/guests/:id/delete', methods: :post },
                'guests#show' => { path: '/guests/:id', methods: [:get] },
                'guests#edit' => { path: '/guests/:id/edit', methods: [:get] },
                'contacts#us' => { path: %w(/contacts /contacts_us /about_us), methods: :get },
                'guests#api' => { path: '/api', methods: %w(get post) },

                'users#new' => { path: '/users/new', methods: [:get] },
                'users#create' => { path: '/users', methods: [:post] },
                'users#login' => { path: '/login', methods: [:get] },
                'users#sign_in' => { path: '/users/sign_in', methods: [:post] },
                'users#logout' => { path: '/logout', methods: [:get] }
              }, binding)


