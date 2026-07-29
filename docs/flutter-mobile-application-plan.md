# VidsPod Flutter Mobile Application Plan

## Objective

Build a new Flutter mobile application for iOS and Android that consumes the VidsPod backend APIs. The mobile app will provide:

- Authentication and user account management
- Dashboard
- Shorts Studio
- Motion/preset discovery and generation
- Profile
- Settings
- Research
- Generation history and video playback

The Flutter application must be a client of the backend. It must not duplicate generation, credit, publishing, provider, or media-processing logic.

## Product boundary

### Flutter owns

- Mobile navigation and screen layouts
- Form state and client-side validation
- Authentication session storage
- Image/video/audio picking and upload UX
- Generation progress presentation
- Playback controls and mobile interactions
- Local cache of safe, non-authoritative data
- Accessibility, responsive layouts, and mobile permissions

### Backend owns

- Authentication and authorization decisions
- Users, profiles, settings, and subscription state
- Motions and publishing readiness
- Credits, reservations, refunds, and usage limits
- Generation workflow state
- AI provider selection and provider calls
- Audio/video composition
- S3 storage and signed URLs
- Research jobs and research results
- Notifications and audit logs

The app must never call Fal, Kling, Veo, S3, Redis, RQ, or n8n directly.

## Recommended technology stack

- Flutter stable channel
- Dart with sound null safety
- Material 3 with VidsPod design tokens
- Riverpod for state management and dependency injection
- `go_router` for navigation and deep links
- `dio` for HTTP requests, interceptors, retries, and cancellation
- `freezed` and `json_serializable` for immutable API models
- `flutter_secure_storage` for refresh tokens and sensitive session data
- `image_picker` and `file_picker` for media selection
- `video_player` for playback; add a caching layer only for approved public media
- `cached_network_image` for thumbnails and reference images
- `connectivity_plus` for connectivity hints, not as a source of truth
- `firebase_messaging` or an equivalent push provider for notifications
- Crash reporting and performance monitoring such as Sentry or Firebase Crashlytics

Use packages only behind small app-owned adapters so they can be replaced later.

## Target project structure

```text
mobile/
├── pubspec.yaml
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart
│   │   ├── router.dart
│   │   ├── theme.dart
│   │   └── config.dart
│   ├── core/
│   │   ├── api/
│   │   ├── auth/
│   │   ├── errors/
│   │   ├── media/
│   │   ├── permissions/
│   │   ├── storage/
│   │   └── widgets/
│   ├── features/
│   │   ├── auth/
│   │   ├── dashboard/
│   │   ├── motions/
│   │   ├── shorts_studio/
│   │   ├── generations/
│   │   ├── profile/
│   │   ├── settings/
│   │   └── research/
│   └── l10n/
└── test/
    ├── core/
    └── features/
```

Each feature should contain its models, repository, state providers/controllers, screens, and widgets. Avoid one global folder containing all screens and all API code.

## API contract required before Flutter implementation

FastAPI should expose a versioned API, for example `/api/v1`. Every response should use consistent error and pagination formats.

### Authentication

```text
POST /api/v1/auth/register
POST /api/v1/auth/login
POST /api/v1/auth/refresh
POST /api/v1/auth/logout
GET  /api/v1/auth/me
```

Use short-lived access tokens and refresh-token rotation. The Flutter app stores tokens securely and attaches the access token through a Dio interceptor. A 401 response should refresh once, retry the request once, and then sign the user out.

### User, profile, and settings

```text
GET   /api/v1/me
PATCH /api/v1/me
GET   /api/v1/me/profile
PATCH /api/v1/me/profile
GET   /api/v1/me/settings
PATCH /api/v1/me/settings
POST  /api/v1/me/avatar/upload-url
```

Settings should return server-supported options and defaults. The app should not hard-code credit plans, model availability, or feature flags.

### Dashboard

```text
GET /api/v1/dashboard/summary
GET /api/v1/dashboard/recent-generations
GET /api/v1/dashboard/recommended-motions
GET /api/v1/dashboard/credit-balance
```

The dashboard should load independently by section so a slow recommendation or research request does not block the entire page.

### Motions

Use the public term `Motion` in the mobile UI even if internal database terminology still uses presets.

```text
GET /api/v1/motions
GET /api/v1/motions/{public_guid}
GET /api/v1/motions/{public_guid}/related
```

Motion detail should include:

- Public GUID and SEO/public title
- Description and usage guidance
- Thumbnail and looping preview video URLs
- Required reference type
- Audio metadata and duration rules
- Credit price
- Supported aspect ratios
- Generation availability

### Shorts Studio

```text
POST /api/v1/uploads/presign
POST /api/v1/generations
GET  /api/v1/generations/{id}
GET  /api/v1/generations/{id}/events
POST /api/v1/generations/{id}/cancel
GET  /api/v1/generations
GET  /api/v1/generations/{id}/media
```

Generation creation must return a generation ID, initial status, reserved credits, workflow type, and progress metadata. The mobile app should use polling initially, with Server-Sent Events or WebSocket support later if required.

The backend must decide whether a request is:

- A predefined image-to-video Motion
- A multishot Motion
- A prompt-driven generation

The mobile client should render the workflow returned by the API and must not infer stages from the Motion name.

### Research

```text
GET  /api/v1/research/topics
POST /api/v1/research/runs
GET  /api/v1/research/runs
GET  /api/v1/research/runs/{id}
GET  /api/v1/research/runs/{id}/results
POST /api/v1/research/runs/{id}/cancel
```

Research can be expensive and asynchronous. Show a compact job card with status, progress, created time, and partial results where the API supports them.

## Main mobile screens

### Authentication

- Welcome
- Sign in
- Create account
- Forgot/reset password
- Email verification
- Session-expired recovery

### Dashboard

Show the most important actions above the fold:

- Create from a Motion
- Recent generations
- Credit balance
- Recommended Motions
- Research shortcut

Avoid loading every dashboard feed before showing the primary actions.

### Motion library

- Search and category filters
- Compact 9:16 Motion cards
- Autoplay preview only when visible and allowed by device/network policy
- Favorite/save action
- Motion detail route using the public GUID

### Motion detail

- Looping preview video
- Motion name, short explanation, duration, and credits
- Reference-image picker
- Audio information when the Motion has predefined audio
- Generate action
- Clear validation messages before submission

The user should not see a prompt field for a predefined Motion unless the backend explicitly declares that the Motion supports variations.

### Shorts Studio

Use a mobile-first sequence:

1. Choose Motion or prompt mode.
2. Select or capture reference image/video.
3. Show required audio and duration rules.
4. Confirm credits and generation settings.
5. Submit generation.
6. Show processing screen with real backend workflow steps.
7. Show the completed player and actions.

The processing screen must distinguish Motion workflow steps from prompt-driven workflow steps. It must never show script, narration, storyboard, or scene pacing for an image-to-video Motion unless the API explicitly returns those stages.

### Generation detail

- Reference media and final output
- Processing progress
- Failure reason and retry action
- Credit status
- Download/share/save actions
- Add, rescale, extend, remix, or other actions only when supported by the backend
- Generation history grouped by complete generation, not by individual shot

### Profile

- Avatar and display name
- Email and account status
- Credit balance/subscription summary
- Generation history
- Saved Motions
- Sign out

### Settings

- Account settings
- Playback and autoplay preferences
- Notification preferences
- Data usage preference
- Theme
- Language
- Privacy and legal links
- Delete-account flow

### Research

- Topic search/create
- Active research jobs
- Result list
- Result detail
- Save/share/export where supported

## State management rules

Use Riverpod providers by feature:

- `authSessionProvider`
- `dashboardSummaryProvider`
- `motionListProvider`
- `motionDetailProvider`
- `shortsStudioDraftProvider`
- `generationProvider`
- `generationHistoryProvider`
- `profileProvider`
- `settingsProvider`
- `researchRunsProvider`

Rules:

- Server state is cached and invalidated through repositories.
- Form drafts are local state until submission.
- Credits are always refreshed from the server after generation creation, completion, failure, refund, or cancellation.
- A generation status from the server is authoritative.
- Do not mark a generation complete because a local timer expired.
- Cancel all media and polling subscriptions when leaving a screen.

## Upload and media handling

Use a presigned-upload flow:

1. Flutter asks FastAPI for an upload URL and upload ID.
2. Flutter uploads directly to the approved S3-compatible URL.
3. Flutter confirms the upload with FastAPI.
4. FastAPI validates MIME type, size, ownership, and media metadata.
5. Generation creation references the validated upload ID.

Canonical storage should remain server-controlled, for example:

```text
projects/{project_guid}/references/images/{asset_guid}.jpg
projects/{project_guid}/references/audio/{asset_guid}.m4a
projects/{project_guid}/generations/{generation_guid}/videos/final.mp4
projects/{project_guid}/generations/{generation_guid}/images/keyframe.png
```

The Flutter app receives signed playback URLs or CDN URLs. It should not construct S3 paths.

## Offline and caching policy

The app may cache:

- Motion thumbnails and public metadata
- Non-sensitive dashboard summaries
- Recently viewed generation metadata
- Local, unsent form drafts

The app must not treat cached data as authoritative for:

- Credits
- Generation status
- Motion publication status
- Subscription state
- Signed media URLs

Private video caching should be opt-in and bounded by size and age. Clear private media on logout when required by the product privacy policy.

## Navigation and deep links

Recommended routes:

```text
/login
/dashboard
/motions
/motions/{public_guid}
/studio
/studio/generation/{id}
/generations
/generations/{id}
/research
/research/{id}
/profile
/settings
```

Support deep links for public Motion pages and generation detail pages. A logged-out user opening a protected generation link should be redirected to login and returned to the original route after authentication.

## Error handling

Use one normalized API error model:

```json
{
  "code": "credits_insufficient",
  "message": "You need 3 more credits to generate this Motion.",
  "field_errors": {},
  "request_id": "req_..."
}
```

Map errors to user actions:

- Validation error → highlight the field
- Insufficient credits → show balance and purchase action
- Unsupported media → show accepted formats and limits
- Generation failure → show reason and retry if safe
- Provider busy → show processing state; do not submit duplicates
- Network failure → preserve draft and offer retry
- Authentication failure → refresh once, then sign in again

## Security requirements

- Store tokens only in secure platform storage.
- Never store provider credentials in the app.
- Never trust client-provided credit prices or workflow types.
- Validate uploads on the server after upload.
- Use signed URLs with short expiry for private media.
- Add device/session revocation support.
- Redact tokens, URLs, prompts, and private media identifiers from logs.
- Support account deletion and data-export requirements.
- Add certificate pinning only after the normal networking flow is stable and operationally supportable.

## Testing strategy

### Backend contract tests

Before implementing each Flutter feature, add FastAPI contract tests for:

- Authentication and refresh
- Pagination and filtering
- Motion detail fields
- Upload lifecycle
- Generation creation and idempotency
- Progress and failure states
- Credit reservation and settlement
- Research job lifecycle

### Flutter tests

- Unit tests for repositories and API mapping
- Provider/controller tests for loading, success, empty, and failure states
- Widget tests for forms and validation
- Golden tests for key compact mobile layouts
- Integration tests for login, Motion generation, playback, and profile settings
- Device tests for camera/gallery permissions, backgrounding, and poor connectivity

### Required end-to-end acceptance flows

1. Sign in and open the dashboard.
2. Open a public Motion through a deep link.
3. Upload a reference image.
4. Generate an image-to-video Motion with predefined audio.
5. Observe real progress without duplicate polling or duplicate charges.
6. Play the final video with audio.
7. Retry a failed generation safely.
8. Change profile and settings.
9. Start research and view results.
10. Sign out and verify private data is no longer accessible.

## Delivery phases

### Phase 0 — API readiness

- Freeze API response models and error format.
- Add `/api/v1` versioning.
- Document OpenAPI schemas.
- Add pagination, idempotency, and request IDs.
- Finish authentication, upload, Motion, generation, profile, settings, and research endpoints.

### Phase 1 — Flutter foundation

- Create the Flutter project in a separate `mobile/` directory.
- Configure environments: development, staging, production.
- Add theme, router, API client, secure storage, logging, and error handling.
- Add CI for format, analyze, tests, and build checks.

### Phase 2 — Account and dashboard

- Implement auth and session restoration.
- Implement profile and settings.
- Implement dashboard summary and recent generations.

### Phase 3 — Motions and Shorts Studio

- Implement Motion library and Motion detail.
- Implement media picker and presigned upload.
- Implement image-to-video Motion flow first.
- Implement processing and generation detail.
- Add multishot only after the API returns explicit multishot workflow metadata.

### Phase 4 — History and research

- Add generation history and playback.
- Add research job creation and results.
- Add notifications and deep links.

### Phase 5 — Release hardening

- Test iOS and Android permissions.
- Test slow networks and interrupted uploads.
- Test background/foreground transitions.
- Run accessibility and performance audits.
- Add crash reporting and staged distribution.

## Project rules to avoid regressions

- The Flutter app consumes documented APIs; it does not reproduce Laravel internals.
- Do not migrate UI screen-by-screen without its API contract and tests.
- Keep Motion workflow branching in backend metadata.
- Keep credit mutations server-side and idempotent.
- Use feature flags for unfinished mobile features.
- Keep the existing web application working while mobile is developed.
- Release one vertical slice at a time and compare web/mobile generation results.

## Definition of done

The mobile application is ready for customer beta when:

- Login, profile, settings, dashboard, Motions, Shorts Studio, generation history, playback, and research work on iOS and Android.
- A customer can complete an image-to-video Motion generation without using the web app.
- The final video includes the configured audio when the Motion requires audio.
- Progress and failures match backend state exactly.
- Credits cannot be duplicated, lost, or bypassed from the client.
- Private media is protected by signed access.
- The app survives interrupted uploads, expired sessions, backgrounding, and poor connectivity.
- Automated tests cover all critical generation and credit flows.
- Crash reporting, analytics, and release rollback procedures are configured.
