# frozen_string_literal: true

require_relative "./test_helper"

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_returns_forms_tag
    user = User.new name: "rob"
    expected_data_without_url = "<form action=\"#\" method=\"post\"></form>"
    actual_data_without_url = HexletCode.form_for user do |f|
    end
    assert { expected_data_without_url == actual_data_without_url }

    expected_data_with_url = "<form action=\"/users\" method=\"post\"></form>"
    actual_data_with_url = HexletCode.form_for user, url: "/users" do |f|
    end
    assert { expected_data_with_url == actual_data_with_url }
  end
end
