class BaseController
  TEMPLATES_ROOT = './world/view'.freeze

  attr_reader :request, :response

  def initialize(request, response)
    @request = request
    @response = response
  end


  protected

  def render(template_name)
    response.body = template(template_name.to_s)
  end


  def params
    @request.query
  end

  private

  def template(key)
    file_path = "#{TEMPLATES_ROOT}/#{key}.html.erb"
    erb = ERB.new(File.read(file_path))
    erb.result(binding)
  end
end