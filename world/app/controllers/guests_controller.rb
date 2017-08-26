class GuestsController < ApplicationController
  def index
    render action: :create, controller: :guests
  end

  def create
    render
  end
end