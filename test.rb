require 'active_support/all'

a = {name: 'jack'}
current_user ||= a[:name].try { |p| "Hello, #{p}" }

p current_user
