# Permissions

Every rule below is enforced by a Pundit policy in `app/policies/`. "Owner", "Counter" and "Mechanic"
are the three values of `User#role`.

## Customers

| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| List / view | Yes | Yes | No |
| Create | Yes | Yes | No |
| Edit | Yes | Yes | No |
| Delete | Yes | No | No |

## Bikes

| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| List / view | Yes | Yes | No |
| Create | Yes | Yes | No |
| Edit | Yes | Yes | No |
| Delete | Yes | No | No |

## Staff

| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| List / view | Yes | Yes | Yes |
| Create | Yes | No | No |
| Edit | Yes | No | No |
| Delete | Yes | No | No |

## Services

| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| List / view | Yes | Yes | Yes |
| Create | Yes | No | No |
| Edit | Yes | No | No |
| Delete | Yes | No | No |

The services list and a service's page also stay visible to a signed-out visitor, as before — the
table above covers signed-in accounts.

## Repairs

| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| Read (list and page) | Every repair | Every repair | Only the repairs where `repair.mechanic` is the staff member joined to their account |
| Take in (create) | Yes | Yes | No |
| Edit | Every repair, including a handed-back one | Every repair **not** handed back | Their own repairs, **not** handed back — and only the `status`, `diagnosis` and `photos` fields |
| Delete | Yes | No | No |

A repair is **handed back** once its `status` is `collected` — the final state of the lifecycle
in [`docs/domain-model.md`](domain-model.md). Once a repair is handed back, only the owner can edit
it, regardless of who was assigned to it.

A mechanic account joined to no staff member (no `mechanic_id`) has no repairs of its own and reads
none — the same empty result on both the index and a direct `/repairs/:id` visit.