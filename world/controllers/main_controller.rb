class MainController < BaseController
  def index
    render(template(:home))
  end
end