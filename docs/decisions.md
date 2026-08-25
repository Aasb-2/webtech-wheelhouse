## Questions for the owner

**1. Is customer approval necessary for all jobs with this system, or is it possible to have simple jobs done without approval?**
Assumption made: only simple/obvious jobs skip straight to `in_progress`; everything else must pass through `awaiting_decision`.
If the answer is otherwise, the `dropped_off → in_progress` transition is removed, and every repair is required to pass through `awaiting_decision`, and wait for the customer's decision.

**2. Should the model record which counter staff member handled a given intake or pickup, or is counter staff interchangeable for record-keeping purposes?**
Assumption made: counter staff actions are not attributed to a named individual; only mechanics are identifiable in case there's problems with the repair, to handle accountability.
If the answer is otherwise, a `counter_staff` (or generalized `employee`) table is added, with the intake and pickup steps on `repairs` recording who performed them.

**3. Is "regular customer" a status the shop tracks formally, or a judgment call a mechanic makes case by case when discounting a price?**
Assumption made: there's no official `regular` identifier for customers. Prices are simply marked differently at the mechanic's discretion, without a recorded reason.
If the answer is otherwise, `customers` gains an `is_regular` boolean, and `repair_line_items` could gain a `discount_reason` field to record why a price differs from list.