MysqlModel.client.query('create database if not exists rudy_2017')
MysqlModel.client.query('use rudy_2017')
MysqlModel.client.query('create table if not exists guest_books (
                                                 id int not null auto_increment primary key
                                                 ,email varchar(255)
                                                 ,nick varchar(255)
                                                 ,text varchar(900)
                                                 ,created_at timestamp
                                                 ,ip varchar(20));')