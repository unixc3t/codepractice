client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => 'admin')

client.query('create database if not exists rudy_2017')
client.query('use rudy_2017')
client.query('create table if not exists guests (email varchar(255)
                                                 ,nick varchar(255)
                                                 ,text varchar(900)
                                                 ,created_at timestamp
                                                 ,ip varchar(20));')