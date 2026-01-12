# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :require_reverification!, only: [:protected], preset: Clerk::StepUp::Preset::STRICT

  def index
    @user = clerk.user
  end

  def protected
    render json: {message: clerk.user? ? 'Valid session' : 'Not logged in'}
  end
end
