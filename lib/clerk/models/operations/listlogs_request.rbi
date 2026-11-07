# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::ListLogsRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::ListLogsRequest
  def starting_after(); end
  def starting_after=(str_); end
  def ending_before(); end
  def ending_before=(str_); end
  def subject(); end
  def subject=(str_); end
  def actor(); end
  def actor=(str_); end
  def user_id(); end
  def user_id=(str_); end
  def identifier(); end
  def identifier=(str_); end
  def trace_id(); end
  def trace_id=(str_); end
  def type(); end
  def type=(str_); end
  def client_id(); end
  def client_id=(str_); end
  def session_id(); end
  def session_id=(str_); end
  def impersonator_user_id(); end
  def impersonator_user_id=(str_); end
  def ip_address(); end
  def ip_address=(str_); end
  def payload_filter(); end
  def payload_filter=(str_); end
  def payload_fields(); end
  def payload_fields=(str_); end
  def event_time_after(); end
  def event_time_after=(str_); end
  def event_time_before(); end
  def event_time_before=(str_); end
  def end_user_facing_only(); end
  def end_user_facing_only=(str_); end
  def group_type(); end
  def group_type=(str_); end
  def status(); end
  def status=(str_); end
  def limit(); end
  def limit=(str_); end
  def filter_match(); end
  def filter_match=(str_); end
  def view(); end
  def view=(str_); end
end
