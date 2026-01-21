# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Clerk::Authenticatable
end
