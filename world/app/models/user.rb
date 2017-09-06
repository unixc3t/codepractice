class User < MysqlModel
  attribute_accessible :email, :nick, :password

  attr_accessor :created_at, :id
end