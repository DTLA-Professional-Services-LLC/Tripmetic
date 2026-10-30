# Group trip Firestore rules

The canonical rules are in the repository root at [`firestore.rules`](../firestore.rules).
Deploy that file to your own Firebase project; do not maintain a second copy of
these rules in documentation.

## What the canonical rules do

- **`group_trips/{tripId}`** — a member can read a trip directly. Collection
  listing is restricted to trips whose `ownerId` is the signed-in user.
- **`group_trips/{tripId}/members/{userId}`** — members can read the member
  list. Only the trip owner or a member with `role: admin` can add, remove, or
  change roles. A signed-in invitee can create only their own `view-only`
  membership, and only when the included invite code maps to that trip.
- **`group_trips/{tripId}/activities/{activityId}`** — members can read;
  the owner, trip admin, or co-planner can create, update, and delete
  activities. A view-only member can update only their own vote.
- **`trip_invite_codes/{code}`** — a direct read is public so an invite link
  can resolve the trip id before sign-in, but collection listing is denied so
  every active invite code cannot be enumerated. Creation/deletion is
  restricted to the trip owner or trip admin.
- Administrative access elsewhere uses the Firebase Auth `admin: true` custom
  claim. Do not add an email allowlist to source-controlled rules.

The create-trip operation is atomic: it creates the trip, the owner's member
record, and the invite mapping together. `getAfter()` lets the rules validate
the owner in that same atomic write without allowing arbitrary members to add
themselves.

Deploy with an explicit project id:

```bash
export FIREBASE_PROJECT_ID="your-firebase-project-id"
firebase deploy --only firestore:rules --project "$FIREBASE_PROJECT_ID"
```
