require "test_helper"

class RepairLineItemTest < ActiveSupport::TestCase
  test "requires price charged" do
    line_item = RepairLineItem.new

    assert_not line_item.valid?
    assert_includes line_item.errors[:price_charged], "can't be blank"
  end

  test "belongs to repair and service item" do
    line_item = repair_line_items(:one)

    assert_respond_to line_item, :repair
    assert_respond_to line_item, :service_item
  end
end