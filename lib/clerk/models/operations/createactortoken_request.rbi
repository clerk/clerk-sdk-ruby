# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateActorTokenRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateActorTokenRequest
  def user_id(); end
  def user_id=(str_); end
  def actor(); end
  def actor=(str_); end
  def expires_in_seconds(); end
  def expires_in_seconds=(str_); end
  def session_max_duration_in_seconds(); end
  def session_max_duration_in_seconds=(str_); end
end