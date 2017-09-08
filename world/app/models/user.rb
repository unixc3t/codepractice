class User < MysqlModel
  AVATAR_PATH = './public/avatars'.freeze
  attribute_accessible :email, :nick, :password

  attr_accessor :created_at, :id

  def exist_avatar?
    File.exist?("#{AVATAR_PATH}/#{id}.png")
  end

  def avatar_path
    "avatars/#{id}.png"
  end
end

