class BaseController

  TEMPLATES = {
    home: ERB.new(File.read('./world/view/home.html.erb')),
    countries: ERB.new(File.read('./world/view/countries.html.erb')),
    regions: ERB.new(File.read('./world/view/regions.html.erb'))
  }.freeze

  attr_reader :request, :response

  def initialize(request, response)
    @request = request
    @response = response
  end


  protected

  def render(result)
    response.body = result
  end

  def template(key)
    TEMPLATES[key].result(binding)
  end
end