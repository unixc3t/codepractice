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

  def new
    @guest = GuestBook.new
    render(template_name: :edit)
  end

  def show
    @guest = GuestBook.find(params['id'])
    render
  end

  def update
    @guest = GuestBook.find(params['id'])
    @guest.update(create_params)

    redirect_to "/guests/#{@guest.id}"
  end

  def edit
    @guest = GuestBook.find(params['id'])
    render
  end

  def api
    render
  end

  private

  def create_params
    params.select do |k, _|
      GuestBook.include_attribute? k
    end.merge('ip' => request.ip)
  end
end
