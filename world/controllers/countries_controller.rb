class CountriesController < BaseController
  def index
    @countries = Country.load!('./world/data/')
    render(template(:countries))
  end
end