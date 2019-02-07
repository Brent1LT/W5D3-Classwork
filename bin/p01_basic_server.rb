require 'rack'

app = Proc.new do |hash_that_has_info_about_request|
  req = Rack::Request.new(hash_that_has_info_about_request)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  res.write("Hello world")
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)