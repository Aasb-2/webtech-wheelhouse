require "test_helper"

class ServiceItemTest < ActiveSupport::TestCase
  test "requires name and current price" do
    service = ServiceItem.new

    assert_not service.valid?
    assert_includes service.errors[:name], "can't be blank"
    assert_includes service.errors[:current_price], "can't be blank"
  end

  test "name must be unique" do
    existing = service_items(:one)

    service = ServiceItem.new(
      name: existing.name,
      current_price: 10
    )

    assert_not service.valid?
    assert_includes service.errors[:name], "has already been taken"
  end

  test "price cannot be negative" do
    service = ServiceItem.new(
      name: "Test service",
      current_price: -1
    )

    assert_not service.valid?
    assert service.errors[:current_price].any?
  end

  test "has many repair line items" do
    service = service_items(:one)

    assert_respond_to service, :repair_line_items
  end
end