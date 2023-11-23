# frozen_string_literal: true

require_relative "./test_helper"

class TestHexletCode < TestCase
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def setup
    @user = User.new(name: "rob", job: "hexlet", gender: "m")
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_that_it_returns_form
    expected_data = load_fixture("data1.html")
    actual_data = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job, as: :text
    end
    assert { expected_data == actual_data }
  end

  def test_that_it_returns_form_with_extra_attrs
    expected_data = load_fixture("data2.html")
    actual_data = HexletCode.form_for @user, url: "#" do |f|
      f.input :name, class: "user-input"
      f.input :job
    end
    assert { expected_data == actual_data }
  end

  def test_that_it_returns_form_with_default_values
    expected_data = load_fixture("data3.html")
    actual_data = HexletCode.form_for @user do |f|
      f.input :job, as: :text
    end
    assert { expected_data == actual_data }
  end

  def test_that_it_returns_form_with_redefined_values
    expected_data = load_fixture("data4.html")
    actual_data = HexletCode.form_for @user, url: "#" do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end
    assert { expected_data == actual_data }
  end

  def test_that_it_returns_form_with_unkonwn_attr
    assert_raises NoMethodError do
      HexletCode.form_for @user, url: "/users" do |f|
        f.input :name
        f.input :job, as: :text
        f.input :age
      end
    end
  end
end
