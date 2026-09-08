require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "requires name and phone" do
    customer = Customer.new

    assert_not customer.valid?
    assert_includes customer.errors[:name], "can't be blank"
    assert_includes customer.errors[:phone], "can't be blank"
  end

  test "can have many bikes" do
    customer = customers(:one)

    assert_respond_to customer, :bikes
  end
end