class UsersController < ApplicationController
  def new
    @user = User.new
    render
  end

  def create
    @user = User.new(create_params)
    @user.save
    redirect_to '/guests'
  end

  def login
    render
  end

  def sign_in
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      if params[:remember].present?
        set_cookies('re_email', encode(params[:email]), Time.now + 1.week)
        set_cookies('re_password', encode(params[:password]), Time.now + 1.week)
      end
    end
    redirect_to '/guests'
  end

  def logout
    session.clear
    set_cookies('re_email', '', Time.now)
    set_cookies('re_password', '', Time.now)
    redirect_to '/login'
  rescue
    puts "error"

  end

  def profile
    render
  end

  def update
    current_user.update(nick: params[:nick])
    p params[:avatar]
    if params[:avatar].present?
      suffix = params[:avatar][:filename].split('.').last
      path = params[:avatar][:tempfile].path

      `cp #{path} #{User::AVATAR_PATH}/#{current_user.id}.#{suffix}`
    end
    redirect_to '/profile'
  end


  private
  def create_params
    params.select do |k, _|
      User.include_attribute? k
    end
  end
end