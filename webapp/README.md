# Tripmetic webapp (Next.js)

Public **Redeem** (`/redeem`) and protected **Super Admin** (`/admin`) UI.

Admin access uses the Firebase Auth `admin` custom claim. Grant it through
`scripts/create_admin_users.js`; do not add an email allowlist to client code.

## Local development

```bash
cp .env.example .env.local
# Fill in the Firebase Web SDK values for your own project.
npm install
npm run dev
```

Open http://localhost:3000/redeem and http://localhost:3000/admin/login

## Production build → Firebase Hosting

From repo root:

```bash
export FIREBASE_PROJECT_ID="your-firebase-project-id"
npm --prefix webapp run build
node scripts/sync-webapp-to-website.js
firebase deploy --only hosting --project "$FIREBASE_PROJECT_ID"
```

Or rely on `firebase.json` hosting `predeploy` hooks.

## Deploy Cloud Functions + rules

```bash
export FIREBASE_PROJECT_ID="your-firebase-project-id"

# Set the RevenueCat secret once in the selected Firebase project:
firebase functions:secrets:set REVENUECAT_SECRET_API_KEY --project "$FIREBASE_PROJECT_ID"

firebase deploy --only functions,firestore:rules --project "$FIREBASE_PROJECT_ID"
```
