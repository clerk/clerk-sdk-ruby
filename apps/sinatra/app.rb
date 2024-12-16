require "active_support"
require "clerk/sinatra"
require "sinatra/base"
require "dotenv"

Dotenv.load("../../.env")

class App < Sinatra::Base
  register Sinatra::Clerk

  before "/protected*" do
    require_reverification!
  end

  get "/" do
    @user = clerk.user
    erb :index, format: :html5
  end

  get "/protected" do
    {message: clerk.user? ? "Valid session" : "Not logged in"}.to_json
  end

  run! if app_file == $0
end
