As a [type of user], I [need/want/am required] to [do something], so that [reason or benefit].

1. As a mechanic, I want the serial number of the bike registered so that there isn't any confusion when there are two identical models.

2. As the counter staff, I need a place where all information regarding bike status is collected so that I don't have to go to the back every time there's a call.

Acceptance criteria:

- Given a bike currently in the shop, the screen shows its current status (e.g. dropped off, waiting for approval, in progress, ready for pickup).
- The status shown on screen matches the status a mechanic most recently recorded, with no need to ask in person.
- Selecting a bike shows which mechanic is currently responsible for it, if one has been assigned.


3. As a customer, I want to know the prices of the services provided so that I don't have to call to ask what a certain service costs.

4. As a mechanic, I want to see the repair history of a bike so that I know what's already been done to it, even if it's changed owners.

Acceptance criteria:
- Given a bike with at least one prior repair, the screen lists each past repair with its date and the services performed.
- Given a bike with no prior repairs, the screen explicitly states there is no repair history, rather than showing an empty list with no explanation (unspecified case).
- Each past repair shown links to (or displays) the diagnosis note written for it at the time.


5. As a mechanic, I would like an image that shows the state the bike arrived in so that there aren't any disputes over damages done to it.

6. As a mechanic, I want to know what day a certain service was due so that I can be aware of any tardiness before being called by the customer.

Acceptance criteria:
- Given a repair with a promised date earlier than today, and a status other than "collected," the screen marks it as overdue.
- A repair that has been collected is never shown as overdue, regardless of its promised date.
- A repair whose promised date is today or in the future is not shown as overdue.


7. As counter staff, I want to record a customer's name and phone number against a bike when it's dropped off so that we know who to contact about it.

8. As a mechanic, I want to write a diagnosis as a proper paragraph or list so that another mechanic or counter staff can understand the problem without deciphering a handwritten tag.

9. [TOO BIG] As a mechanic, I want to manage the quote and approval process for a repair so that work only proceeds when appropriate.

   Splits into:

   9a. As a mechanic, I want to record a quote for a repair so that the customer knows what it will cost before agreeing to anything.

   9b. As a mechanic, I want to record the customer's decision (approved or declined) so that I know whether to start work or return the bike as-is.

   Acceptance criteria:
    - Given a repair with a quote and no recorded decision yet, work cannot be marked as started.
    - Recording "approved" allows the repair's status to move to "in progress."
    - Recording "declined" moves the repair to a status indicating it is ready for pickup with no work done.

10. As counter staff, I want to record that a customer picked up their bike, whether or not work was done, so that the shop's records reflect what actually happened to it.

11. As a mechanic, I want to charge less than the list price for a service when it's justified (a regular customer, an easier job) so that pricing stays fair without changing the wall list.

12. As a mechanic, I want an invoice to keep the price that was charged at the time, even after the price list changes in January, so that old invoices don't silently change.