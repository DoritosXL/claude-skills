---
name: copy-it
description: >
  Activated by the /copy-it command (with or without a URL appended). Runs a
  narrated, phased pipeline that crawls a target website using the user's own
  Chrome browser via the Claude in Chrome extension, maps its UI/UX and
  functionality, and generates a pixel-perfect working codebase as a template
  the user can build on. Requires Claude Code CLI with Chrome integration active.

compatibility:
  runtime: Claude Code CLI
  required_tools:
    - Claude in Chrome extension (connected via /chrome or --chrome flag)
    - bash_tool (for running local dev server and file operations)
    - create_file / str_replace (for generating code and documentation)
  user_prerequisites:
    - Claude Code CLI installed
    - Claude in Chrome extension installed and connected (run /chrome to verify)
    - Node.js + npm installed (for running the generated project)
    - Google Chrome or Microsoft Edge
---

# Copy Pipeline — /copy-it

A narrated, phased pipeline that turns any public URL into a pixel-perfect,
editable codebase. Uses Claude Code's native Chrome integration — no Playwright,
no headless browser, no separate tooling. Claude navigates your real browser,
sees what you see, and the target site sees a real human.

---

## Trigger Behaviour

If the user types `/copy-it https://example.com` → verify Chrome is connected, then begin pipeline.
If the user types `/copy-it` alone → respond with exactly:

```
/copy-it — Copy Pipeline ready.

Drop the URL you want to clone:
```

Wait for URL input, then begin pipeline.

### Chrome connection check:
Before doing anything else, verify the Chrome extension is active. If not connected:
```
[INIT] Chrome extension not detected. Run /chrome to connect, then retry /copy-it.
```

---

## Pipeline Narration Style

This skill must feel like a pipeline system — not a chatbot. Every action is
announced before it runs and confirmed after. Use this voice throughout:

```
[PHASE 1 / UI DISCOVERY] Opening target in Chrome...
  ✓ Found 8 routes
  ✓ Captured 16 screenshots (desktop + mobile)
  ⚠ Auth wall detected at /dashboard — flagged for placeholder

[PHASE 1 / UI DISCOVERY] Complete. Preparing visual report...
```

Never go silent. If a step takes time, say so:
```
[PHASE 1 / SCREENSHOTS] Capturing /portfolio — navigating and screenshotting...
```

---

## Per-Site Documentation File

**Create this file at the very start of the pipeline** and update it after
every phase. It is both the agent's working memory and a deliverable for the user.

### File naming:
```
{domain}-{timestamp}.md
e.g. acme-co-2024-03-15.md
```

### File location:
Create in `/copy-it-output/{domain}/` in the user's working directory.

### Read `references/site-doc-template.md` for the full template structure.

Update this file progressively:
- After Phase 1: fill in routes, screenshots inventory, animation notes
- After Phase 2: fill in interaction map, API endpoints, timer findings
- After Gate B: mark everything user-validated
- After Phase 3: record chosen tech stack + reasoning
- After Phase 4: fill in generation summary, known gaps, TODOs

Present a preview of this file at each gate as part of validation.

---

## Mental Model

```
/copy-it [url]
  │
  ▼
[INIT] Verify Chrome connected → create output directory + site doc
  │
  ▼
[PHASE 1: UI/UX DISCOVERY]
  ├── Navigate all routes in Chrome
  ├── Screenshot every page (desktop + mobile viewport)
  ├── Map interactive elements + animations via DOM inspection
  ├── Update site doc
  └── ── GATE A: Annotated page map + doc preview → user validates ──
  │
  ▼
[PHASE 2: FUNCTIONALITY DISCOVERY]
  ├── Interact with every element in Chrome
  ├── Monitor network tab — capture API calls + response shapes
  ├── Detect timers + JS-driven behaviour via console
  ├── Update site doc
  └── ── GATE B: Interaction story map + doc preview → user validates ──
  │
  ▼
[PHASE 3: TECH STACK SELECTION]
  ├── Score complexity from observed signals
  ├── Present tiered options with evidence
  └── ── GATE C: User selects stack ──
  │
  ▼
[PHASE 4: GENERATION LOOP]
  ├── Scaffold project structure
  ├── Generate code (pixel-perfect target)
  ├── Run local dev server via bash
  ├── Open generated output in Chrome
  ├── Diff visually against original screenshots
  ├── Iterate on divergences
  └── ── GATE D: Final diff summary → user approves ──
  │
  ▼
[DONE] Present output directory + final site doc
```

---

## Phase 1 — UI/UX Discovery

Read `references/phase1-discovery.md` for detailed capture instructions.

### How it works with Chrome integration:
Claude Code navigates your real Chrome browser to each discovered route.
No scripts to run — Claude drives the browser directly, takes screenshots,
inspects the DOM, and reads computed styles natively.

### Narration:
```
[PHASE 1 / INIT] Navigating to {url} in Chrome...
[PHASE 1 / ROUTE CRAWL] Mapping all routes from nav, links, and sitemap...
[PHASE 1 / SCREENSHOTS] Capturing {route} at desktop (1440px)...
[PHASE 1 / SCREENSHOTS] Capturing {route} at mobile (390px)...
[PHASE 1 / ANALYSIS] Reading DOM — detecting interactive elements and animations...
[PHASE 1 / COOKIES] Dismissing cookie consent dialog if present...
[PHASE 1 / DOCS] Updating {domain}-{timestamp}.md...
```

### What to capture:
- All routes (nav links, anchor tags, JS router paths, sitemap if available)
- Full-page screenshots at desktop (1440px) and mobile (390px) per route
- Scroll states where content differs (lazy load, sticky nav, parallax)
- Interactive elements — buttons, links, forms, dropdowns, modals
- Animations — CSS keyframes, JS-driven, scroll-triggered — note type + location
- Cookie/consent dialogs — dismiss before screenshotting
- Auth walls — screenshot the wall, flag route, do not attempt to bypass

### Gate A output:
1. Annotated page map — all routes with screenshot references, element counts,
   animation flags, auth wall flags
2. Preview of site doc so far
3. Ask:
```
[GATE A] Here's everything I found across {n} routes.

Does this look complete? Any pages, states, or interactions I missed?
(Reply "looks good" to continue, or describe what's missing)
```

---

## Phase 2 — Functionality Discovery

Read `references/phase2-functionality.md` for detailed interaction instructions.

### How it works with Chrome integration:
Claude clicks every interactive element directly in your Chrome browser,
watches what changes in the DOM, and reads the network panel to capture
API calls. Console access lets it detect timers and JS behaviour.

### Narration:
```
[PHASE 2 / INTERACTIONS] Clicking all interactive elements on {page}...
[PHASE 2 / NETWORK] Reading network calls triggered by {element}...
[PHASE 2 / CONSOLE] Scanning console for timers and scheduled events...
[PHASE 2 / ANIMATIONS] Reading computed styles and keyframes...
[PHASE 2 / DOCS] Updating {domain}-{timestamp}.md with interaction map...
```

### What to capture:
- Every clickable element → what changes in DOM / navigation / network calls
- Every form → fields, validation behaviour, endpoint + payload + response shape
- All fetch/XHR calls → method, URL, request shape, response shape (structure only)
- Timer/interval events → observed via console, what they trigger, cadence
- CSS animations → read computed keyframes + transition properties from DOM
- JS animations → identify library from loaded scripts (GSAP, Framer, etc.)

### Gate B output:
1. Interaction story map — anchored to Phase 1 validated UI, plain language
2. Updated site doc with full functionality section
3. Ask:
```
[GATE B] Here's what every element does, grouped by page.

Does this match your expectations? Anything wrong or missing?
(Reply "looks good" to continue, or describe corrections)
```

---

## Phase 3 — Tech Stack Selection

Read `references/phase3-techstack.md` for scoring rubric and decision tree.

### Narration:
```
[PHASE 3 / ANALYSIS] Scoring site complexity from observed signals...
[PHASE 3 / RECOMMENDATION] Preparing tech stack options...
```

Always present 3 tiers, grounded in evidence. Record choice in site doc.

### Gate C:
```
[GATE C] Based on what I found ({n} routes, {n} API endpoints, {complexity} complexity):

1. [Primary recommendation + why]
2. [Alternative + why]
3. [Simpler option + why]

Which would you like? (Or name another stack if you prefer)
```

---

## Phase 4 — Generation Loop

Read `references/phase4-generation.md` for scaffolding, mock conventions, diff loop.

### How it works with Chrome integration:
Claude generates the codebase, starts a local dev server via bash, then opens
the running output directly in Chrome. It navigates both the original and the
generated version side by side to diff visually — no external tooling needed.

### Narration:
```
[PHASE 4 / SCAFFOLD] Creating project in /copy-it-output/{domain}/...
[PHASE 4 / GENERATE] Building {page} — targeting pixel-perfect match...
[PHASE 4 / SERVER] Starting local dev server on localhost:{port}...
[PHASE 4 / DIFF] Opening generated output in Chrome — comparing to original...
[PHASE 4 / ITERATION {n}] Fixing divergences — {layout/colour/spacing/detail}...
[PHASE 4 / DOCS] Finalising {domain}-{timestamp}.md...
```

### Pixel-perfect is the goal:
Iterate until layout, colour, typography, spacing, interactions, and animations
all match at both viewports. Document gaps honestly — never accept them silently.

### Gate D:
```
[GATE D] Generation complete. Final fidelity report:

✅ Pixel-perfect: [list]
⚠️  Approximated (reason): [list]
🔒 Auth placeholders: [list]
📋 TODOs in code: {n} — all marked // MOCK or // TODO

Output: /copy-it-output/{domain}/
Documentation: /copy-it-output/{domain}/{domain}-{timestamp}.md

Want me to fix anything before you take over?
```

---

## Output Directory Structure

```
/copy-it-output/
└── {domain}/
    ├── {domain}-{timestamp}.md     ← living documentation file
    ├── screenshots/
    │   ├── original/               ← Phase 1 captures
    │   └── generated/              ← Phase 4 diff captures
    └── {project}/                  ← generated codebase
        ├── app/ (or src/)
        ├── components/
        ├── lib/
        │   └── mock-data.ts
        └── ...
```

---

## Reference Files

| File | When to read |
|------|-------------|
| `references/site-doc-template.md` | At pipeline init — create the site doc |
| `references/phase1-discovery.md` | Before Phase 1 — Chrome-based capture instructions |
| `references/phase2-functionality.md` | Before Phase 2 — Chrome interaction + network reading |
| `references/phase3-techstack.md` | Before Phase 3 — complexity scoring + stack options |
| `references/phase4-generation.md` | Before Phase 4 — scaffolding, mocks, diff loop |