require "test_helper"

class BikeTest < ActiveSupport::TestCase
  test "requires model and serial number" do
    bike = Bike.new

    assert_not bike.valid?
    assert_includes bike.errors[:model], "can't be blank"
    assert_includes bike.errors[:serial_number], "can't be blank"
  end

  test "serial number must be unique" do
    existing = bikes(:one)

    bike = Bike.new(
      customer: existing.customer,
      model: "Another Bike",
      serial_number: existing.serial_number
    )

    assert_not bike.valid?
    assert_includes bike.errors[:serial_number], "has already been taken"
  end

  test "belongs to a customer and has many repairs" do
    bike = bikes(:one)

    assert_respond_to bike, :customer
    assert_respond_to bike, :repairs
  end
end