require "test_helper"

class MechanicTest < ActiveSupport::TestCase
  test "requires name" do
    mechanic = Mechanic.new

    assert_not mechanic.valid?
    assert_includes mechanic.errors[:name], "can't be blank"
  end

  test "has many repairs" do
    mechanic = mechanics(:one)

    assert_respond_to mechanic, :repairs
  end
end