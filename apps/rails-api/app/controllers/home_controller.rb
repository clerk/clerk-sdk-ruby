class HomeController < ApplicationController
  def index
    render json: clerk.user || {message: "Not authenticated"}
  end
end
