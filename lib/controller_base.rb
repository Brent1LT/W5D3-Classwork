require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'byebug'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response ||= false
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Double render error" if already_built_response?
    @res.status = 302
    @res['Location'] = url
    @already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Double render error" if already_built_response?
    @res["Content-Type"] = content_type
    @res.write(content)
    @already_built_response = true
    
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    path = File.dirname(File.dirname(__FILE__))
    file_path = File.join(path, 'views', self.class.name.underscore, "#{template_name}.html.erb")
    content = File.read(file_path)
    erb_code = ERB.new(content).result(binding)
    render_content(erb_code, "text/html")
  end

  # method exposing a `Session` object
  def session 

  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end

#   app = Proc.new do |env|
#   req = Rack::Request.new(env)
#   res = Rack::Response.new
#   res['Content-Type'] = 'text/html'
#   res.write("Hello world!")
#   res.finish
# end
end

# puts F + "/views"



