# Group trip Firestore rules (merge into your project)

**Do not deploy this file alone** as your only `firestore.rules` — it would leave every other collection locked. Copy the `match` blocks below into your existing `firestore.rules` (or merge with your Firebase Console rules editor).

## What these rules do

- **`group_trips/{tripId}`** — members can read; only **owner** or a member with **`role: admin`** can update or delete the trip document (supports “delete trip” and “edit trip” in the app).
- **`group_trips/{tripId}/members/{userId}`** — members can read; only owner or trip admin can write (add/remove/change roles).
- **`group_trips/{tripId}/activities/{activityId}`** — members can read; **owner, trip admin, or co-planner** can create/update/delete activities.
- **`trip_invite_codes/{code}`** — **public read** so invite links can resolve the trip id before sign-in; create/delete restricted to trip owner or trip admin.

## Snippet

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    function signedIn() {
      return request.auth != null;
    }

    function tripPath(tripId) {
      return /databases/$(database)/documents/group_trips/$(tripId);
    }

    function memberPath(tripId) {
      return tripPath(tripId) / 'members' / request.auth.uid;
    }

    function tripExists(tripId) {
      return exists(tripPath(tripId));
    }

    function tripOwnerId(tripId) {
      return get(tripPath(tripId)).data.ownerId;
    }

    function isTripMember(tripId) {
      return signedIn() && exists(memberPath(tripId));
    }

    function memberRole(tripId) {
      return get(memberPath(tripId)).data.role;
    }

    function isTripOwner(tripId) {
      return signedIn()
        && tripExists(tripId)
        && tripOwnerId(tripId) == request.auth.uid;
    }

    function isTripAdminMember(tripId) {
      return isTripMember(tripId) && memberRole(tripId) == 'admin';
    }

    function isTripOwnerOrAdmin(tripId) {
      return isTripOwner(tripId) || isTripAdminMember(tripId);
    }

    function isTripPlanner(tripId) {
      return isTripOwnerOrAdmin(tripId)
        || (isTripMember(tripId) && memberRole(tripId) == 'co-planner');
    }

    match /group_trips/{tripId} {
      allow read: if isTripMember(tripId);
      allow create: if signedIn()
        && request.resource.data.ownerId == request.auth.uid;
      allow update, delete: if isTripOwnerOrAdmin(tripId);

      match /members/{userId} {
        allow read: if isTripMember(tripId);
        allow create, update, delete: if isTripOwnerOrAdmin(tripId);
      }

      match /activities/{activityId} {
        allow read: if isTripMember(tripId);
        allow create: if isTripPlanner(tripId);
        allow update, delete: if isTripPlanner(tripId);
      }
    }

    match /trip_invite_codes/{code} {
      allow read: if true;
      allow create: if signedIn()
        && request.resource.data.keys().hasAll(['tripId'])
        && tripExists(request.resource.data.tripId)
        && isTripOwnerOrAdmin(request.resource.data.tripId);
      allow delete: if signedIn()
        && resource.data.keys().hasAll(['tripId'])
        && tripExists(resource.data.tripId)
        && isTripOwnerOrAdmin(resource.data.tripId);
      allow update: if false;
    }

    // … your other match /users/{uid}, /bucket_list/…, etc.
  }
}
```

After merging, run:

`firebase deploy --only firestore:rules`

(or publish from the Firebase Console).
