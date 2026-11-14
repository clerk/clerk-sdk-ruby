# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::LogWithPayload
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::LogWithPayload
  def object(); end
  def object=(str_); end
  def id(); end
  def id=(str_); end
  def event_time(); end
  def event_time=(str_); end
  def actor(); end
  def actor=(str_); end
  def subject(); end
  def subject=(str_); end
  def type(); end
  def type=(str_); end
  def trace_id(); end
  def trace_id=(str_); end
  def span_id(); end
  def span_id=(str_); end
  def event_context(); end
  def event_context=(str_); end
  def payload(); end
  def payload=(str_); end
  def actor_type(); end
  def actor_type=(str_); end
  def source(); end
  def source=(str_); end
  def impersonator(); end
  def impersonator=(str_); end
  def client_id(); end
  def client_id=(str_); end
  def session_id(); end
  def session_id=(str_); end
  def parent_span_id(); end
  def parent_span_id=(str_); end
  def group_id(); end
  def group_id=(str_); end
  def group_type(); end
  def group_type=(str_); end
  def group_started_at(); end
  def group_started_at=(str_); end
end
