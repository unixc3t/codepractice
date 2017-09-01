class GuestsController < ApplicationController
  def index
    @guest_books = GuestBook.where(nick: params[:nick])
    render
  end

  def create
    guest_book = GuestBook.new(create_params)
    guest_book.save
    redirect_to '/guests'
  end


  def destroy
    guestbook = GuestBook.find(params['id'])
    guestbook.destroy
    redirect_to '/guests'
  end

  def api
    render
  end

  private

  def create_params
    params.select { |k, _|
      GuestBook.include_attribute? k
    }.merge('ip' => request.ip)
  end
end