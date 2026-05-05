# claude-skills

My personal collection of Claude Code skills — split into skills I've built myself and community skills I rely on daily.

## Install

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
