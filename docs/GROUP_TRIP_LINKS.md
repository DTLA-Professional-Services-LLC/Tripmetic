# Group trip invite links (`https://tripmetic.app/group-trip/...`)

The app registers **Android App Links** and a **`tripmetic://` custom URL scheme**. Invite messages now include:

- HTTPS link (best when **Digital Asset Links** + **Apple App Site Association** are configured).
- **`tripmetic://group-trip/CODE`** (opens the app when the OS allows custom schemes).
- **Android intent URL** — opens the app if installed, otherwise sends the user to **Google Play** (no server file required for that path).

## What you should host on `tripmetic.app`

### 1. Smart landing page (recommended)

When a user opens the HTTPS link in a **browser** (not verified as an app link), serve a small HTML page that:

1. Parses the invite code from the path (`/group-trip/ABC123`).
2. Offers an **“Open in Tripmetic”** button using `tripmetic://group-trip/ABC123` (required on many iOS browsers).
3. Links to the **App Store** and **Play Store** for users without the app.

A reference page lives in this repo:

`web/group-trip/index.html`

**Deploy it** so that **every** path under `/group-trip/*` serves that file (SPA-style). Examples:

**Nginx**

```nginx
location /group-trip/ {
  try_files $uri /group-trip/index.html;
}
```

**Firebase Hosting** (`firebase.json`)

```json
{
  "hosting": {
    "public": "web",
    "rewrites": [
      { "source": "/group-trip/**", "destination": "/group-trip/index.html" }
    ]
  }
}
```

(Adjust `public` to wherever you upload `group-trip/index.html`.)

### 2. Android App Links (HTTPS opens the app directly)

Host:

`https://tripmetic.app/.well-known/assetlinks.json`

Content must list your app id `com.tripmetic.app` and your **release signing SHA-256**.  
See: https://developer.android.com/training/app-links/verify-android-applinks

### 3. iOS Universal Links

1. In Xcode, add **Associated Domains**: `applinks:tripmetic.app`.
2. Host **AASA** (no `.json` extension):

`https://tripmetic.app/.well-known/apple-app-site-association`

Include your team id + bundle id.  
See: https://developer.apple.com/documentation/xcode/supporting-associated-domains

### 4. iOS custom scheme

The app registers the **`tripmetic`** URL scheme in `Info.plist` so `tripmetic://group-trip/...` can open Tripmetic from Mail/Messages when Universal Links are not used.

## Store URLs (also in `GroupTripPaths`)

- iOS: `https://apps.apple.com/us/app/tripmetic/id6765632920`
- Android: `https://play.google.com/store/apps/details?id=com.tripmetic.app`
