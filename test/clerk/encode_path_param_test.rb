# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/clerk/utils/url'

class EncodePathParamTest < Minitest::Test
  def test_encodes_forward_slash
    assert_equal '%2F', Clerk::Utils._encode_path_param('/')
  end

  def test_encodes_dot
    assert_equal '%2E', Clerk::Utils._encode_path_param('.')
  end

  def test_encodes_dots_and_slashes_in_composite_value
    encoded = Clerk::Utils._encode_path_param('a.b/c.d')
    refute_includes encoded, '/'
    refute_includes encoded, '.'
  end

  def test_still_encodes_previously_handled_characters
    {
      '<' => '%3C', '>' => '%3E', '{' => '%7B', '}' => '%7D',
      '[' => '%5B', ']' => '%5D', '|' => '%7C', '\\' => '%5C',
      '^' => '%5E', '`' => '%60', ' ' => '%20', '?' => '%3F',
      '#' => '%23', '%' => '%25'
    }.each do |char, expected|
      assert_equal expected, Clerk::Utils._encode_path_param(char), "char: #{char.inspect}"
    end
  end

  def test_leaves_typical_resource_id_untouched
    id = 'user_2abcXYZ_def-ghi~jkl'
    assert_equal id, Clerk::Utils._encode_path_param(id)
  end

  def test_already_encoded_value_is_double_encoded_safely
    assert_equal '%252F', Clerk::Utils._encode_path_param('%2F')
  end
end
