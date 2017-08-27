class GuestsController < ApplicationController
  def index
    @guest_books = GuestBook.all
    render
  end

  def create
    guest_book = GuestBook.new(create_params)
    guest_book.save
    redirect_to '/'
  end


  private

  def create_params
    params.select { |k, _|
      GuestBook::AVAILABLE_ATTRS.include? k
    }.merge('ip' => request.remote_ip)
  end
end