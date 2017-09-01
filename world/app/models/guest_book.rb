class GuestBook < MysqlModel
  attribute_accessible :email, :ip, :nick, :text


  attr_accessor :created_at,:id

  def created_human_at
    time_at = Time.at(created_at.to_i)
    "#{time_at.year}-#{time_at.month}-#{time_at.day}"
  end
end