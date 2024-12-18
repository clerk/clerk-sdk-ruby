class ApplicationController < ActionController::API
  include Clerk::Authenticatable
end
