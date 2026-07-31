# VidsPod Mobile — Feature & Implementation Guide

Audience: the Flutter app team (human or AI agent) plus the backend engineers who
expose the mobile API surface.

Status of this document: **design contract**. The API shapes below describe what
mobile will consume. Some already exist in FastAPI, some exist only in the legacy
Laravel app, some do not exist anywhere yet. Every endpoint is tagged so nobody
builds a client against something imaginary:

| Tag | Meaning |
| --- | --- |
| ✅ **LIVE** | Implemented in FastAPI today, shape verified against the code |
| 🟡 **LARAVEL-ONLY** | Works in the legacy Laravel app; must be ported to FastAPI before mobile can use it |
| 🔴 **TO BUILD** | Exists nowhere; new backend work |

Node-Js API reference project path: /Users/rafi/developer/ai_development/projects/vidspod-ai/vidspod-js/
Laravel reference project path: /Users/rafi/developer/ai_development/projects/vidspod-ai/
---

## 1. Product scope

### 1.1 What mobile ships (v1)

Mobile is a **creation and monitoring** companion, not a full editor. The
timeline editor (Studio) is desktop-only in v1 — it is a drag-and-drop,
multi-track surface that does not survive a 6" screen.

| # | Feature | Why it belongs on mobile |
| --- | --- | --- |
| 1 | Auth & account | Table stakes |
| 2 | Home / dashboard | Credits, recent work, quick actions |
| 3 | **Shorts Studio** (Motions) | The flagship one-tap flow: pick a Motion, upload a selfie, generate. Perfect for phones — the camera is right there |
| 4 | **My Shorts** | Watch, retry, cancel, download, share the results |
| 5 | **Image Generator** | Upload/shoot a photo, enhance or restyle it |
| 6 | **Video generation** (AI Video / Full Auto / Cinema / Marketing studios) | Prompt-to-video; submit on mobile, monitor, watch |
| 7 | Projects list + project detail (read/monitor) | Track renders, play finals, share |
| 8 | Script Writer | Text-first, works great on a phone |
| 9 | Voice Studio / voice clones | Record a sample on-device |
| 10 | **Research suite** (Topic Explorer, Trend Tracker, Audience Insights, Competition Analysis, Content Gap Finder, Content Planner, Platform Adaptation, Reports) | Read-heavy, ideal for commuting |
| 11 | **YouTube tools**: Video Downloader, Niche Finder | Downloader must save to the device gallery |
| 12 | Publishing queue (read + schedule) | Approve/schedule from anywhere |
| 13 | Motions catalog (public browse) | Discovery, share links |
| 14 | Billing / credits / upgrade | Paywall (see §10 on store rules) |

### 1.2 Explicitly NOT in v1

Timeline Studio editor, Preset Visual Builder, the entire `/admin` area,
Brand Kits editing, Pipelines internals, Content Ops. Deep links to these open
the web app in a browser tab.

---

## 2. Where the truth lives (repo map for the Flutter agent)

Monorepo root: `vidspod-ai/`. Two stacks live side by side during the migration.

```
vidspod-ai/
├── app/, resources/js/, routes/web.php     ← LEGACY Laravel + Inertia (reference implementation)
└── vidspod-js/                             ← TARGET stack
    ├── backend/
    │   ├── apps/api/app/                   ← FastAPI service (the mobile API)
    │   │   ├── api/router.py               ← route table: every prefix in one file
    │   │   ├── api/routers/*.py            ← endpoint definitions
    │   │   ├── schemas/*.py                ← REQUEST/RESPONSE SHAPES — generate Dart models from here
    │   │   ├── application/**/service.py   ← business rules
    │   │   ├── domain/**                   ← enums (UserRole, statuses, shot options)
    │   │   └── infrastructure/db/models/   ← SQLAlchemy tables
    │   ├── apps/worker/app/jobs/           ← async jobs (thin today — see §9)
    │   └── scripts/seed_database.py        ← seed data incl. the Motion catalog
    ├── frontend/apps/web/                  ← Next.js web app (UI reference for parity)
    │   ├── app/(app)/**/page.tsx           ← one folder per screen; mirror these flows
    │   ├── features/**                     ← feature views
    │   └── lib/*.ts                        ← typed API clients — closest thing to a client SDK spec
    ├── docs/                               ← this file, porting inventory, status
    └── infra/compose/                      ← local stack (postgres, minio, redis, api, web)
```

**Rules for the Flutter agent**

1. **Never invent a field.** A response model is defined in
   `vidspod-js/backend/apps/api/app/schemas/<feature>.py`. That file is the
   contract. If the field is not there, it does not exist.
2. **For UX/flow questions**, read the matching Next.js page under
   `vidspod-js/frontend/apps/web/app/(app)/…` — it is the current product.
3. **For behaviour the web port is missing**, read the Laravel original under
   `resources/js/Pages/…` + `app/Http/Controllers/…`. The Next port is still in
   progress and is not always complete.
4. **For which endpoints exist**, `grep -n "prefix=" vidspod-js/backend/apps/api/app/api/router.py`.
5. **For design tokens**, `vidspod-js/frontend/apps/web/app/(app)/app.css` — the
   `--vr-*` variables are the source palette (see §11).

### 2.1 Screen → code map

| Mobile screen | Web page (flow reference) | Legacy reference | API schema |
| --- | --- | --- | --- |
| Shorts Studio | `app/(app)/generate/short-studio/page.tsx` | `resources/js/Pages/GenerateHub.jsx` | `schemas/generate_hub.py` |
| Video studios | `app/(app)/generate/studio/[slug]/page.tsx` | same | `schemas/generate_hub.py` |
| My Shorts | `app/(app)/my-shorts/page.tsx` | `Pages/MyShorts/Index.jsx` | `schemas/my_shorts.py` |
| Projects | `app/(app)/projects/page.tsx` | `Pages/Projects/…` | `schemas/projects.py` |
| Image Generator | `features/image-generator/image-generator-view.tsx` (stub) | `Pages/Tools/ImageGenerator.jsx` (**full**) | 🔴 none yet |
| Research | `app/(app)/content-research/**` | `Pages/ContentResearch/**` | `schemas/content_research.py` |
| YouTube tools | `app/(app)/tools/youtube/**` | `Pages/YouTube/**` | 🔴 none yet |
| Voice Studio | `app/(app)/voice-studio/page.tsx` | `Pages/VoiceStudio.jsx` | `schemas/voices.py` |
| Script Writer | `app/(app)/script-writer/page.tsx` | `Pages/ScriptWriter.jsx` | 🟡 placeholder |
| Publishing | `app/(app)/publishing/page.tsx` | `Pages/Publishing.jsx` | `schemas/publishing.py` |
| Motions catalog | `app/(marketing)/motions/**` | — | `schemas/motions.py` |

---

## 3. API conventions

Base URL: `{API_ORIGIN}/api/v1`. Local dev: `http://localhost:8000/api/v1`
(container `vidspod-dev-api-1`, also proxied by the web app at `/api/*`).

### 3.1 Envelope

Every response uses the same wrapper (`app/schemas/common.py`):

```jsonc
{
  "data":  { /* payload, null on error */ },
  "meta":  { "request_id": "01J…" },
  "error": { "code": "validation_failed", "message": "…",
             "fields": { "prompt": ["required"] }, "request_id": "01J…" }
}
```

Dart: one `ApiResponse<T>` generic, one `ApiException(code, message, fields)`.
Always surface `request_id` in bug reports.

### 3.2 Pagination

Two styles exist; do not unify them client-side, mirror them:

- **Keyset** (projects): `?limit=20&cursor=<opaque>` → `data.items[]`,
  `data.next_cursor` (null = end). Use for infinite scroll.
- **Page number** (my-shorts): `?page=2&per_page=20` → `data.pagination{page,…}`.

### 3.3 Media URLs

The API returns **absolute, ready-to-play URLs** (`*_url` fields), resolved from
object storage server-side. Never build a URL from a `*_path` field — those are
internal object keys. If a `*_url` is null the asset genuinely is not ready.

### 3.4 Errors

| HTTP | Meaning | Client behaviour |
| --- | --- | --- |
| 401 | Session invalid/expired | Drop token, route to login |
| 402 / `code: insufficient_credits` | Out of credits | Open paywall sheet |
| 422 | Validation | Map `error.fields` onto form fields |
| 409 | Conflicting run state | Refresh the run, re-render actions |
| 429 | Rate limited | Exponential backoff, respect `Retry-After` |

---

## 4. Authentication (🔴 needs backend work before anything else)

**Current state:** FastAPI auth is browser-shaped — HttpOnly session cookie plus
a double-submit CSRF cookie (`app/api/routers/auth.py`). A mobile app should not
be juggling CSRF cookies.

**Required additions:**

| Method | Path | Tag | Notes |
| --- | --- | --- | --- |
| POST | `/auth/mobile/login` | 🔴 | `{email, password, device_name, platform}` → `{access_token, refresh_token, expires_in, user}` |
| POST | `/auth/mobile/refresh` | 🔴 | Rotating refresh token |
| POST | `/auth/mobile/logout` | 🔴 | Revoke this device's session only |
| GET | `/auth/session` | ✅ | Works today; accept `Authorization: Bearer` in addition to cookies |
| POST | `/auth/password/forgot` · `/reset` | ✅ | Reuse as-is |
| POST | `/auth/email/verification` · `/verify` | ✅ | Reuse as-is |
| GET/POST | `/account/profile`, `/profile/change-password`, `/profile/change-email` | ✅ | Reuse as-is |
| 🔴 | Social sign-in (Apple required if any social login ships on iOS) | | |

Implementation note for backend: keep one `sessions` row per device
(`device_name`, `platform`, `last_seen_at`) so users can revoke a lost phone.

Flutter: store tokens in `flutter_secure_storage`. One Dio interceptor attaches
the bearer, catches 401, refreshes once, replays the request, and hard-logs-out
on a second failure.

---

## 5. Feature specs

Each feature: what the user does, the screens, and the API surface.

---

### 5.1 Home / Dashboard

**User story:** open the app → see credit balance, in-flight runs, recent
outputs, and one-tap entries into the studios.

| Method | Path | Tag | Payload |
| --- | --- | --- | --- |
| GET | `/dashboard` | ✅ | Studios list, showcase videos, stats, recent projects |
| GET | `/projects/overview` | ✅ | `{total, completed, in_progress, failed, by_status[]}` |
| GET | `/settings` · `/settings/theme` | ✅ | Feature switches + theme mode |
| GET | `/account/credits` | 🔴 | `{balance, plan, renews_at, costs:{script_generation, ai_image_generation, …}}` — today credit costs are embedded per-payload; mobile needs one endpoint |

**Screens:** Home (credit chip, "Create" CTA, in-progress runs carousel, recent
grid).

---

### 5.2 Shorts Studio ⭐ flagship

**User story:** pick a **Motion** (a pre-built vertical style, some are one-click
"clone" workflows), attach a reference photo (camera or gallery), tap Generate,
watch progress, get a 9:16 video.

**Critical domain rule** (do not re-implement client-side): the Motion list for
Shorts Studio is *not* the public Motion catalog. The server applies a strict
eligibility gate — tagged `short-studio`, exactly `9:16`, has cover art or a
template clip, clone workflows must carry a complete shot table, at least one
usable model key, `release_validation.passed`, and
`launch_profile.customer_visible`. See
`backend/apps/api/app/application/direction/preset_eligibility.py`.
**Mobile renders `format_presets` exactly as returned. Never filter it.**

Second rule: **selecting a Motion hydrates the whole form.** `prompt`, `genre`,
`speed`, `camera_movements`, `shots_mode`, `scene_count`, `audio_enabled`,
`model_key` and `style_pack` all come from the preset. Shorts Studio is locked to
9:16 regardless of what the preset says. A preset carrying `workflow.shots[]` is
a **clone Motion** and submits to a different endpoint with no scene controls.

| Method | Path | Tag | Notes |
| --- | --- | --- | --- |
| GET | `/generate/hub?flow_category=short-studio` | ✅ | Everything the screen needs: `flow_meta`, `format_presets[]`, `style_packs[]`, `ai_video_products[]`, `camera_movements`, `aspect_ratios`, `user_elements[]`, `hero_background_video`, `generation_cost` |
| POST | `/presets/generate` | 🔴 (🟡 in Laravel as `shorts.generate.store`) | Clone-Motion submit. multipart: `preset_key`, `reference_image`, optional `title` → `{generation_run_id}` |
| POST | `/projects` | 🔴 (🟡 in Laravel as `projects.store`) | Standard Motion submit. multipart: `prompt`, `format_preset`, `reference_image`, `aspect_ratio=9:16`, `predefined_motion`, hydrated production fields → `{project_id, generation_run_id}` |
| GET | `/my-shorts?run_id=…` | ✅ | Progress polling (see §9) |

**Screens**
1. **Studio home** — hero video background, Motion slot, reference-image slot,
   credit cost, primary CTA. Mirrors the web hero card.
2. **Motion picker** (full-screen sheet) — 9:16 grid, autoplaying preview clips,
   "One-click clone" vs "Style reference" badge.
3. **Reference capture** — camera / gallery / recent uploads. Any aspect ratio is
   accepted; the only hard limit is **10 MB** (`max:10240` KB server-side).
4. **Submitting → run progress** — stage label + message, cancel.
5. **Result** — player, save to gallery, share, retry, "make another".

**Client validation** (match the server exactly): a Motion must be selected; a
reference image is required when `requires_reference_image`; ≤10 MB; a prompt is
optional whenever a Motion is selected.

---

### 5.3 My Shorts (run monitoring)

`schemas/my_shorts.py` is unusually rich — use all of it rather than inventing
mobile-side status logic.

| Method | Path | Tag |
| --- | --- | --- |
| GET | `/my-shorts?page=&per_page=&status=` | ✅ |
| POST | `/my-shorts/{run_id}/retry` | ✅ |
| POST | `/my-shorts/{run_id}/cancel` | ✅ |
| DELETE | `/my-shorts/{run_id}/media` | ✅ |
| GET | `/my-shorts/{run_id}/download` | 🟡 | Laravel serves a signed URL; mobile needs `{url, expires_at}` to hand to the downloader |

Per run you get: `status`, `status_label`, `stage_key`, `stage_label`,
`stage_message`, `preset_name`, `aspect_ratio`, `reference_image_url`,
`submitted_references[]`, `playback_url`, `playback_ready`, `output_width/height`,
`duration_seconds`, `can_retry`, `can_cancel`, `can_delete_media`,
`credit_settlement{reserved,charged,refunded,net}`, `refund_status`. Plus a
`stats` block and `pagination`.

**Render `*_label` / `stage_message` verbatim.** Drive buttons off the `can_*`
booleans — never off a status string.

---

### 5.4 Image Generator

**Backend reality check:** the Next.js page is a 142-line stub with a fake submit.
The real product is Laravel's `resources/js/Pages/Tools/ImageGenerator.jsx` (626
lines) + `app/Http/Controllers/Tools/ImageGeneratorController.php`. **FastAPI has
no image endpoints at all** — only the `image_generations` table. Build the API
from the Laravel controller, and treat the Laravel page as the UX spec.

**User story:** shoot or pick a photo → choose **Reference Edit** or **Improve** →
prompt → size + variation count → generate → save / send to a project / turn into
a video.

| Method | Path | Tag | Shape |
| --- | --- | --- | --- |
| GET | `/tools/image-generator` | 🔴 | `{credit_info, cost_per_image, default_model, model_options[], projects[], history[]}` |
| POST | `/tools/image-generator` | 🔴 | multipart: `mode` (`image_to_image`\|`improve`), `prompt` (≤4000, required unless `improve`), `model`, `size` (`1024x1024`\|`1024x1536`\|`1536x1024`), `variation_count` (1–4, forced to 1 for `improve`), `source_image` (required, ≤10 MB), `project_id?` → `{generation_id}` |
| GET | `/tools/image-generator/{id}/status` | 🔴 | `{id, status, result_urls[], result_paths[], project_id, error_message}` |
| POST | `/tools/image-generator/{id}/media-assets` | 🔴 | `{project_id}` → attach outputs to a project's media library |

**Screens:** capture/pick → options sheet (mode, size, variations, model, project)
→ generating → results carousel (save to gallery, share, attach to project,
"make a video from this").

Cost = `cost_per_image × variation_count`; block submit and open the paywall when
the balance is short — same rule as the web app.

---

### 5.5 Video generation (AI Video / Full Auto / Cinema / Marketing / net-new studios)

All studios are the **same hub payload** with a different `flow_category`. Web
routes: `/generate/{video|ai-video-studio|full-auto-studio|cinema-studio|marketing-studio}`
and the generic `/generate/studio/{slug}`. Mobile should drive its studio list
from `/dashboard` → `studios[]` rather than hardcoding.

| Method | Path | Tag |
| --- | --- | --- |
| GET | `/generate/hub?flow_category={slug}` | ✅ |
| POST | `/projects` | 🔴 (🟡 Laravel) |
| GET | `/projects/{id}` | ✅ |
| POST | `/projects/{id}/generation-runs/{run_id}/{pause\|resume\|cancel\|retry}` | 🔴 (🟡 Laravel) |

**Mobile simplification:** the desktop hub exposes ~15 production controls
(camera movement, lens, lighting, colour grade, motion intensity, realism, shot
mode, scene count…). Mobile shows **prompt + style pack + aspect ratio +
duration** on the main sheet and hides the rest behind "Advanced". All options
come from the hub payload (`camera_options`, `lens_options`, `lighting_options`,
`color_grade_options`, `motion_intensity_options`, `realism_options`) — never
hardcode them.

**Screens:** studio picker → prompt sheet → style pack grid → advanced (collapsed)
→ cost + generate → run progress → project detail.

---

### 5.6 Projects

| Method | Path | Tag |
| --- | --- | --- |
| GET | `/projects?limit=&cursor=&status=` | ✅ |
| GET | `/projects/overview` | ✅ |
| GET | `/projects/{id}` | ✅ (scenes, narration, renders, versions) |
| DELETE | `/projects/{id}` | 🔴 |

Mobile is read + monitor + play + share. "Edit in Studio" opens the web app.

> Known data gap: `final_url` / `preview_url` are null for every migrated
> project because the legacy importer defers media resolution
> (`scripts/migration/data_import/projects.py`). Mobile must render a graceful
> placeholder, not an error, when a completed project has no playable URL.

---

### 5.7 Script Writer

| Method | Path | Tag |
| --- | --- | --- |
| POST | `/generate/script` | 🟡 **placeholder** — returns canned text, not a real LLM call |
| POST | `/generate/narration` | 🟡 placeholder |
| GET | `/script-writer/history` | 🔴 |

Real behaviour lives in `app/Http/Controllers/ScriptWriterController.php`.
Screens: prompt + tone + audience + length → generated script (editable) →
"send to video" handoff → history.

---

### 5.8 Voice Studio & voice clones

| Method | Path | Tag |
| --- | --- | --- |
| GET | `/voices` | ✅ catalog |
| GET/POST | `/voices/settings` | ✅ per-user TTS defaults |
| POST | `/voices/clones` | 🔴 upload/record a sample |
| GET | `/voices/clones` | 🔴 |
| POST | `/voices/preview` | 🔴 TTS preview of arbitrary text |

Mobile advantage: record the clone sample in-app. Ask for mic permission at the
point of use, show a level meter, enforce the sample length the backend requires.

---

### 5.9 Research suite

One nav section, eight tools, one backend today.

| Method | Path | Tag |
| --- | --- | --- |
| GET | `/content-research` | ✅ saved research, exports, recent searches |
| POST | `/content-research/search` | ✅ run a research query |
| 🔴 | Per-tool endpoints for Topic Explorer, Trend Tracker, Audience Insights, Competition Analysis, Content Gap Finder, Content Planner, Platform Adaptation, Reports Workspace | | Web pages exist under `app/(app)/content-research/**`; check each for whether it calls a real endpoint or renders static scaffolding before promising it on mobile |

**Mobile pattern:** a single "Research" tab → tool grid → each tool is
search-input → result cards → save/export → "turn into a script/video" handoff.
Cache results locally; this is the most-used offline surface.

---

### 5.10 YouTube tools

**Video Downloader** — the highest-value mobile tool (saving to the camera roll
is something the web cannot do).

| Method | Path | Tag |
| --- | --- | --- |
| POST | `/tools/youtube/downloader/info` | 🔴 (🟡 Laravel) `{url}` → `{title, thumbnail, duration, formats[]}` |
| POST | `/tools/youtube/downloader/download` | 🔴 (🟡) `{url, format_id}` → `{download_id}` |
| GET | `/tools/youtube/downloader/{id}/status` | 🔴 (🟡) `{status, progress, error}` |
| GET | `/tools/youtube/downloader/{id}/file` | 🔴 (🟡) signed file URL |

Flow: paste/share-sheet a URL → info card → pick format/quality → server-side job
→ download to device → save to gallery. **Register the app as a share target for
`youtube.com`/`youtu.be` links** — this is the single best mobile-only affordance
in the product.

**Niche Finder**

| Method | Path | Tag |
| --- | --- | --- |
| POST | `/tools/youtube/niche-finder/search` | 🔴 (🟡) |
| POST | `/tools/youtube/niche-finder/favorite` | 🔴 (🟡) |

Also present in Laravel and worth porting later: YouTube OAuth connect/disconnect
(`/auth/youtube/*`) for channel-aware features.

---

### 5.11 Publishing

| Method | Path | Tag |
| --- | --- | --- |
| GET | `/publishing` | ✅ queue + connected accounts |
| POST | `/publishing/schedule` | 🔴 |
| POST | `/publishing/{id}/{approve\|cancel}` | 🔴 |

Mobile: review a scheduled post, approve or cancel, reschedule. Actual OAuth
connection flows stay on web in v1.

---

### 5.12 Motions catalog (public)

| Method | Path | Tag |
| --- | --- | --- |
| GET | `/motions` | ✅ |
| GET | `/motions/{public_id}` | ✅ |

Vertical, TikTok-style browse of preview clips → "Use this Motion" jumps straight
into Shorts Studio with the Motion preselected. Supports universal links for
sharing.

---

### 5.13 Billing & credits

| Method | Path | Tag |
| --- | --- | --- |
| GET | `/account/credits` | 🔴 |
| GET | `/account/billing` | 🔴 |
| POST | `/billing/mobile/verify-receipt` | 🔴 |

See §10 — store policy, not just engineering.

---

## 6. Flutter project structure

Feature-first, so each feature folder maps 1:1 to a section above.

```
vidspod_mobile/
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart                     # MaterialApp.router, theme wiring
│   │   ├── router.dart                   # go_router: routes, guards, deep links
│   │   └── bootstrap.dart                # DI, env, error reporting
│   ├── core/
│   │   ├── api/
│   │   │   ├── api_client.dart           # Dio + envelope unwrap
│   │   │   ├── interceptors/             # auth, retry, logging, request_id
│   │   │   ├── api_response.dart         # ApiResponse<T>, ApiException
│   │   │   └── endpoints.dart            # every path string, one place
│   │   ├── auth/                         # token store, session controller
│   │   ├── storage/                      # secure storage, cache, downloads
│   │   ├── media/                        # picker, camera, compression, gallery save
│   │   ├── polling/                      # run poller (see §9)
│   │   ├── theme/                        # tokens ported from app.css (see §11)
│   │   └── widgets/                      # buttons, cards, sheets, empty/error states
│   ├── features/
│   │   ├── auth/                         # login, register, forgot, verify
│   │   ├── home/                         # dashboard
│   │   ├── shorts_studio/                # ⭐ motion picker, reference capture, submit
│   │   ├── my_shorts/                    # run list, run detail, player
│   │   ├── image_generator/
│   │   ├── video_studio/                 # all hub-driven studios
│   │   ├── projects/
│   │   ├── script_writer/
│   │   ├── voice_studio/
│   │   ├── research/                     # 8 tools, shared result widgets
│   │   ├── youtube_tools/                # downloader + niche finder
│   │   ├── publishing/
│   │   ├── motions_catalog/
│   │   └── billing/
│   └── shared/
│       ├── models/                       # generated from FastAPI schemas
│       └── utils/
├── test/            # unit + widget
├── integration_test/
└── pubspec.yaml
```

Inside every `features/<name>/`:

```
data/        # <name>_repository.dart, dto mappers
domain/      # entities, value objects, validation rules
presentation/
  screens/   # one file per screen
  widgets/   # feature-local widgets
  controllers/ # riverpod notifiers (or bloc — pick one and keep it)
```

**Suggested stack:** `dio` + `retrofit`, `riverpod` (state), `go_router`
(navigation), `freezed` + `json_serializable` (models), `flutter_secure_storage`,
`cached_network_image`, `video_player`/`chewie`, `image_picker` + `camera`,
`permission_handler`, `gal` (save to gallery), `share_plus`, `firebase_messaging`
(push), `sentry_flutter`.

---

## 7. Core data models (Dart, from the FastAPI schemas)

Generate these from `backend/apps/api/app/schemas/`; do not hand-write drift.

```dart
// from schemas/generate_hub.py
class FormatPreset {            // a "Motion"
  final String key, publicId, label, description;
  final String? imageUrl, previewVideoUrl, styleReferenceImageUrl,
                templateVideoUrl, aspectRatio, stylePack;
  final int durationSeconds, sceneCount, batchSize;
  final List<String> categories, cameraMovements;
  final String generationMode, prompt, genre, speed, shotsMode, modelKey;
  final bool requiresReferenceImage, audioEnabled;
  final Map<String, dynamic>? workflow;   // non-null ⇒ one-click clone Motion
  bool get isCloneMotion => (workflow?['shots'] as List?)?.isNotEmpty ?? false;
}

// from schemas/my_shorts.py
class ShortRun {
  final String id, status, statusLabel, stageKey, stageLabel, stageMessage;
  final String presetName, presetKey, aspectRatio;
  final String? referenceImageUrl, playbackUrl;
  final bool playbackReady, canRetry, canCancel, canDeleteMedia;
  final int outputWidth, outputHeight, durationSeconds;
  final CreditSettlement creditSettlement;
  final String refundStatus;
  final DateTime createdAt;
}

// from schemas/projects.py
class ProjectListItem {
  final String id, title, status, creationMode, aspectRatio;
  final int targetDurationSeconds;
  final String? previewUrl, finalUrl;
  final DateTime createdAt, updatedAt;
}
```

---

## 8. Cross-cutting UX requirements

- **Uploads:** compress before upload; hard-fail over 10 MB with a clear message
  (the server rejects it anyway). Show real progress; allow background upload.
- **Video playback:** vertical-first player, tap-to-mute, scrubber, no autoplay
  on cellular unless the user opted in.
- **Save to gallery:** every finished video/image gets a Save action —
  the main reason a creator installs the app.
- **Share:** share sheet with the public URL; app registers as a share *target*
  for YouTube links.
- **Offline:** cache dashboard, Motion catalog, research results, and run lists.
  Queue nothing that costs credits while offline — surface "no connection"
  instead of a silent retry that double-charges.
- **Empty / error / loading** states are required on every screen; copy comes
  from the web app so the products read the same.
- **Accessibility:** dynamic type, ≥44pt touch targets, semantic labels on icon
  buttons, captions on preview videos where available.

---

## 9. Async generation & progress

Everything expensive is a **job**, not a request. The pattern:

```
POST /…/generate      → { generation_run_id }
GET  /my-shorts?run_id=…   (or /projects/{id})   ← poll
     status: queued → processing (stage_key/stage_label/stage_message) →
             completed (playback_url) | failed (error) | cancelled
```

**Polling policy:** 2s for the first 30s, then 5s, then 10s after 2 minutes; stop
when backgrounded and resume on foreground; hard-stop after 30 minutes and show
"still running — check My Shorts".

**Backend note:** `vidspod-js/backend/apps/worker/app/jobs/` currently holds only
auth-email, catalog-derivative, fairness, lifecycle and provider-result jobs. The
generation pipeline itself (script → narration → scenes → AI video → render) is
**not yet ported** from Laravel. Mobile submit endpoints cannot be finished ahead
of that work.

**Push (🔴):** register a device token, get a notification when a run completes or
fails. This is what makes long generations tolerable on a phone — treat it as v1
scope, not a nice-to-have.

| Method | Path | Tag |
| --- | --- | --- |
| POST | `/devices/register` | 🔴 `{token, platform, app_version}` |
| DELETE | `/devices/{token}` | 🔴 |

---

## 10. Store & platform constraints

- **In-app purchase:** Apple and Google require IAP for digital credits bought
  in-app. Web-purchased credits may be *used* in the app. Plan for
  `POST /billing/mobile/verify-receipt` and a server-side entitlement check.
- **UGC rules:** AI generation from user photos needs a report/block path and a
  visible content policy, or App Review will reject.
- **YouTube downloader:** review the store policies and YouTube ToS before
  shipping this to the public app stores; it may need to be gated, reframed
  (own-content only), or omitted from the store build.
- **Permissions:** camera, photo library, microphone, notifications — each with a
  purpose string and asked at point of use, never on launch.

---

## 11. Design system

Port the tokens from `vidspod-js/frontend/apps/web/app/(app)/app.css`. Three
themes exist and mobile should honour the account's choice:

| Theme | `--vr-primary` | `--vr-bg` |
| --- | --- | --- |
| light | `#6d5df6` | `#f5f7fd` |
| venture (ventura1, dark) | `#e06036` | `#090b11` |
| ventura2 (dark) | `#ff7a2f` | `#05060b` |

Read the mode from `GET /settings/theme`. Build one Dart `VrTheme` class holding
the same token names (`vrPrimary`, `vrSurface`, `vrText`, `vrTextSoft`,
`vrTextMuted`, `vrBorder`, …) so web and mobile stay describable in one
vocabulary. Radii 8/10/14/18/22, matching `--vr-radius-*`.

---

## 12. Delivery plan

| Phase | Backend | Mobile |
| --- | --- | --- |
| **0 — Foundation** | Mobile auth (§4), `/account/credits`, device registration | Project skeleton, API client, auth flow, theming, navigation shell |
| **1 — Shorts Studio** | `POST /presets/generate`, `POST /projects`, my-shorts download URL | Studio, Motion picker, capture, run progress, My Shorts, player, save/share |
| **2 — Consume & monitor** | — (all ✅ today) | Home, Projects, project detail, Motions catalog, research read paths |
| **3 — Image Generator** | Full `/tools/image-generator/*` (§5.4) | Capture → options → results → attach/share |
| **4 — Video studios** | `POST /projects` + run controls | Studio picker, prompt sheet, advanced options, monitoring |
| **5 — Tools** | YouTube downloader + niche finder, script writer, voice clones | Share-target intake, downloads, gallery saves |
| **6 — Monetisation & polish** | IAP receipt verification, push fan-out | Paywall, notifications, offline cache, a11y pass |

**Hard dependency:** phases 1, 3 and 4 all sit behind the generation pipeline
port (§9). Sequence the backend work accordingly — mobile can build phase 0 and 2
against what is live today.

---

## 13. Open questions for product

1. Does the phone need the timeline editor at all, or is "edit on desktop"
   acceptable for v1? (This guide assumes the latter.)
2. Is the YouTube downloader shipping in the public store build?
3. Credits: IAP-only in-app, or read-only balance with purchase on web?
4. Offline: are cached research reports expected to be exportable offline?
