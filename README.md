# claude-skills

My personal collection of Claude Code skills and subagents — split into skills I've built myself, community skills I rely on daily, and subagents tuned to my own stack.

## Install skills

1. Clone this repo
2. Copy the skill folder(s) you want into `~/.claude/skills/`
3. Restart Claude Code

**Mac / Linux:**

```bash
git clone https://github.com/DoritosXL/claude-skills.git
cp -r claude-skills/self-made/copy-it ~/.claude/skills/
```

**Windows (PowerShell):**

```powershell
git clone https://github.com/DoritosXL/claude-skills.git
Copy-Item -Recurse claude-skills\self-made\copy-it $env:USERPROFILE\.claude\skills\
```

Replace `self-made/copy-it` with whichever skill(s) you want from the list below.

## Install agents

Agents here are tuned to *my* stack (dstark, Next.js/Vite, Tailwind v4 — see each agent's file for specifics), so treat them as a reference to adapt rather than drop-in for a different stack.

**Mac / Linux:**

```bash
git clone https://github.com/DoritosXL/claude-skills.git
ln -s "$(pwd)/claude-skills/agents/frontend-engineer.md" ~/.claude/agents/frontend-engineer.md
ln -s "$(pwd)/claude-skills/agents/design-system-maintainer.md" ~/.claude/agents/design-system-maintainer.md
```

A symlink (rather than a copy) keeps the local, functional copy under `~/.claude/agents/` and the version-controlled source in this repo as the same file — edit either path, both update.

---

## Self-made Skills

Skills I've built and maintain myself.

### `/copy-it`

Clone any public website into a pixel-perfect, editable codebase. Claude navigates your real Chrome browser, maps the UI and functionality, and generates a working project you can build on — no Playwright, no headless browser.

**Prerequisites:**
- [Claude Code CLI](https://claude.ai/code)
- [Claude in Chrome extension](https://chromewebstore.google.com/detail/claude-in-chrome/kcpefmnomlhaldmookgajfleoiipgkdd) — connected via `/chrome`
- Node.js + npm
- Google Chrome or Microsoft Edge

---

## Community Skills

Skills built by others that I use and recommend. Links go to the original source so you can follow the author and get updates directly.

### `/grill-me`

Get relentlessly interviewed about your plan or design until every branch of the decision tree is resolved. One of the most useful habits you can build before starting any feature.

**By:** [Matt Pocock](https://github.com/mattpocock) — [mattpocock/skills](https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md)

**Prerequisites:**
- Claude Code (no special requirements)

---

## Agents

Subagents tuned to my own projects and stack.

### `frontend-engineer`

React/Next.js/Vite frontend specialist. Knows my real stack — dstark as the default UI library, Tailwind v4, the shadcn/Radix + cva pattern in older repos, Storybook + Vitest + Playwright for testing — so it defaults to established conventions instead of generic scaffolding, and checks UI changes in a real browser before calling them done.

**Prerequisites:**
- Claude Code CLI
- [Claude in Chrome extension](https://chromewebstore.google.com/detail/claude-in-chrome/kcpefmnomlhaldmookgajfleoiipgkdd) for visual verification of UI changes (optional but recommended)

### `design-system-maintainer`

Maintains [dstark](https://github.com/DoritosXL/dstark) instead of letting consuming projects build one-off duplicates. Given a missing or under-built UI element, builds it in dstark's own repo, ships it through dstark's branch+PR+release-please pipeline, and completes the release so it's live on npm — then hops back to the consuming project and upgrades it.

**Prerequisites:**
- Claude Code CLI
- Local clone of `DoritosXL/dstark`
- `gh` CLI, authenticated with a token that can open/merge PRs on the repo
