require "test_helper"

class RepairTest < ActiveSupport::TestCase
  test "requires dropped off time" do
    repair = Repair.new

    assert_not repair.valid?
    assert_includes repair.errors[:dropped_off_at], "can't be blank"
  end

  test "accepts valid statuses" do
    Repair::STATUSES.each do |status|
      repair = repairs(:one)
      repair.status = status

      assert repair.valid?, "#{status} should be valid"
    end
  end

  test "rejects invalid status" do
    repair = repairs(:one)
    repair.status = "something_invalid"

    assert_not repair.valid?
    assert repair.errors[:status].any?
  end

  test "allows simple repair to start from dropped off" do
    repair = repairs(:one)
    repair.status = "dropped_off"
    repair.decision = nil

    repair.move_to!("in_progress")

    assert_equal "in_progress", repair.status
  end

  test "allows approved repair to start" do
    repair = repairs(:one)
    repair.status = "awaiting_decision"
    repair.decision = "approved"

    repair.move_to!("in_progress")

    assert_equal "in_progress", repair.status
  end

  test "allows declined repair to become ready for pickup" do
    repair = repairs(:one)
    repair.status = "awaiting_decision"
    repair.decision = "declined"

    repair.move_to!("ready_for_pickup")

    assert_equal "ready_for_pickup", repair.status
  end

  test "does not allow collected repair to move anywhere" do
    repair = repairs(:one)
    repair.status = "collected"

    assert_raises(ActiveRecord::RecordInvalid) do
      repair.move_to!("in_progress")
    end
  end

  test "does not allow ready repair to return to progress" do
    repair = repairs(:one)
    repair.status = "ready_for_pickup"

    assert_raises(ActiveRecord::RecordInvalid) do
      repair.move_to!("in_progress")
    end
  end

  test "overdue means promised date is before today and repair is not collected" do
    repair = repairs(:one)
    repair.promised_on = Date.current - 1.day
    repair.status = "in_progress"

    assert repair.overdue?
  end

  test "collected repairs are never overdue" do
    repair = repairs(:one)
    repair.promised_on = Date.current - 1.day
    repair.status = "collected"

    assert_not repair.overdue?
  end
end