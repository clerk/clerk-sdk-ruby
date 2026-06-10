# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateAgentTaskRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateAgentTaskRequest
  def on_behalf_of(); end
  def on_behalf_of=(str_); end
  def permissions(); end
  def permissions=(str_); end
  def agent_name(); end
  def agent_name=(str_); end
  def task_description(); end
  def task_description=(str_); end
  def redirect_url(); end
  def redirect_url=(str_); end
  def session_max_duration_in_seconds(); end
  def session_max_duration_in_seconds=(str_); end
end
