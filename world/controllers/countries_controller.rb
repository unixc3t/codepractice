class CountriesController < BaseController
  def index

    @countries = Country.load!('./world/data/')
    @search    = params['country_str']
    if !@search.nil? && !@search.empty?
      @countries = @countries.select { |country| country.title.include? @search }
    end
    render(:countries)
  end
end