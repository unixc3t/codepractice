class ApplicationController
  TEMPLATES_ROOT = File.expand_path('../view', File.dirname(__FILE__)).freeze

  attr_reader :request, :response,
              :controller_name, :action_name

  def initialize(request,
                 response,
                 controller_name,
                 action_name)
    @request = request
    @response = response
    @controller_name = controller_name
    @action_name = action_name
  end


  protected

  def render(template_name: nil, action: nil, controller: nil)
    folder = controller || controller_name
    file = template_name || action || action_name
    response.body = template(folder, file)
  end


  def params
    @request.query
  end

  private

  def template(folder, file)
    erb = ERB.new(File.read(template_name(folder, file)))
    erb.result(binding)
  end

  def template_name(folder, file)
    "#{TEMPLATES_ROOT}/#{folder}/#{file}.html.erb"
  end
end