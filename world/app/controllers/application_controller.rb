class ApplicationController
  TEMPLATES_ROOT = File.expand_path('../view', File.dirname(__FILE__)).freeze

  attr_reader :request, :response,
              :controller_name, :action_name, :params

  def initialize(request,
                 response,
                 params,
                 controller_name,
                 action_name)
    @request = request
    @response = response
    @params = params
    @controller_name = controller_name
    @action_name = action_name
  end


  protected

  def redirect_to(path)
    response['Location'] = '/'
    response.status = '301'
  end

  def render(template_name: nil, action: nil, controller: nil)
    folder = controller || controller_name
    file = template_name || action || action_name
    response.body = template(folder, file)
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