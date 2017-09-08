class ApplicationController
  TEMPLATES_ROOT = File.expand_path('../view', File.dirname(__FILE__)).freeze
  PARTIAL_FOLDER = 'partials'.freeze
  LAYOUT_FOLDER = 'layouts'.freeze

  attr_reader :request, :response,
              :controller_name, :action_name,
              :params, :session

  def initialize(request,
                 response,
                 params,
                 session,

                 controller_name,
                 action_name)
    @request = request
    @response = response
    @params = params
    @session = session
    @controller_name = controller_name
    @action_name = action_name
    update_remember_me
  end

  protected


  def cookies
    request.cookies
  end

  def update_remember_me
    return if !(cookies[:re_email].present? && cookies[:re_password].present?)
    set_cookies(:re_email, cookies[:re_email])
    set_cookies(:re_password, cookies[:re_password])
  end

  def set_cookies(key, value, expires = Time.now + 1.week)
    response.set_cookie(key, value: value, expires: expires, httponly: false)
  end

  def redirect_to(_path)
    response['Location'] = '/'
    response.status = '302'
  end

  def render(template_name: nil, action: nil, controller: nil)
    folder = controller || controller_name
    file = template_name || action || action_name
    response.body = render_layout do
      template(folder, file)
    end
  end

  def render_partial(template_name)
    template(PARTIAL_FOLDER, template_name)
  end

  def current_user
    @current_user ||= if session[:user_id].present?
                        User.find(session[:user_id])
                      else
                        if cookies['re_email'].present? && cookies['re_password'].present?
                          set_session_id
                        end
                      end
  end

  private

  def set_session_id
    user = User.find_by(email: dencode(cookies['re_email']), password: dencode(cookies['re_password']))
    session[:user_id] = user.id if user
    user
  end

  def template(folder, file)
    erb = ERB.new(File.read(template_name(folder, file)))
    erb.result(binding)
  end

  def template_name(folder, file)
    "#{TEMPLATES_ROOT}/#{folder}/#{file}.html.erb"
  end

  def render_layout
    erb = ERB.new(File.read(template_name(LAYOUT_FOLDER, layout)))
    erb.result(binding)
  end

  def layout
    :application
  end

  def encode(str)
    Base64.encode64(str)
  end

  def dencode(str)
    Base64.decode64(str)
  end
end
