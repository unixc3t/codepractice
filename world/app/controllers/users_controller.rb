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
    p 'user'
    p @user
    p 'user'
    session[:user_id] = @user.id if @user
    redirect_to '/guests'
  end

  def logout
    session[:user_id] = nil
    redirect_to '/guests'
  end

  private
  def create_params
    params.select do |k, _|
      User.include_attribute? k
    end
  end
end