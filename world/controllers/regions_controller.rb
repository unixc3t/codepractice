class RegionsController < BaseController
  def index
    countries = Country.load!('./world/data/')
    @country  = countries.find { |c| c.cid.to_s == params['country_id'] }
    @regions  = @country.respond_to?(:regions) ? @country.regions : []
    render(:index)
  end
end