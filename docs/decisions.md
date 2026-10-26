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


## Account role default

**The default role is `counter`.**

Of the three roles, `counter` has the narrowest slice of the application: a counter-desk account
only records intake and pickup — who dropped off a bike, who collected it — and reads what's
already in the system. A `mechanic` account changes a repair's status, diagnosis and the services
charged against it: judgment calls tied directly to the work on the bike. An `owner` account
carries the full run of the shop, with no narrower duties below it.

Giving `counter` to every freshly-created account — through the sign-up form, or a request
written by hand that sends `user[role]=owner` — means a new account starts with the least it can
do to the data. Promoting it to `mechanic` or `owner` is a deliberate act performed from the seed
or the console, by someone who already has that authority.