require 'dashing'

configure do
  #set :auth_token, 'YOUR_AUTH_TOKEN'

  helpers do
    def protected!
      # response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      # throw(:halt, [401, "Not authorized\n"])
    end

    def authorized?
    #@auth ||=  Rack::Auth::Basic::Request.new(request.env)
    #@auth.provided? && @auth.basic? && @auth.credentials && #@auth.credentials == ['admin', 'veVTBfAhm3jGEkRjuQTJaCyY']
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
