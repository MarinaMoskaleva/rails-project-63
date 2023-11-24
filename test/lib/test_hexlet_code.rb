# frozen_string_literal: true

require_relative '../test_helper'

class TestHexletCode < TestCase
  User = Struct.new(:name, :job, keyword_init: true)

  def setup
    @user = User.new job: 'hexlet'
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_that_it_returns_form_with_submit
    expected_data = load_fixture('data_with_default_btntext.html')
    actual_data = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    assert { expected_data == actual_data }
  end

  def test_that_it_returns_form_with_submit_and_custom_btn
    expected_data = load_fixture('data_with_custom_btntext.html')
    actual_data = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end
    assert { expected_data == actual_data }
  end
end
