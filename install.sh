#!/usr/bin/env bash
set -e

# When piped via curl | sh, stdin is the pipe — redirect to terminal for interactive prompts
exec < /dev/tty

SKILLS_DIR="$HOME/.claude/skills"
REPO="DoritosXL/claude-skills"
BASE_URL="https://raw.githubusercontent.com/$REPO/main"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

printf "\n"
printf "${BOLD}${BLUE}Claude Skills Installer${NC}\n"
printf "github.com/%s\n" "$REPO"
printf "\n"

mkdir -p "$SKILLS_DIR"

install_skill() {
  local category=$1
  local skill=$2
  local skill_dir="$SKILLS_DIR/$skill"

  mkdir -p "$skill_dir"
  curl -fsSL "$BASE_URL/$category/$skill/SKILL.md" -o "$skill_dir/SKILL.md"
  printf "  ${GREEN}✓${NC} %s\n" "$skill"
}

printf "${BOLD}Self-made skills:${NC}\n"
printf "  1) copy-it    — Clone any website into a working codebase\n"
printf "\n"
printf "${BOLD}Community skills:${NC}\n"
printf "  2) grill-me   — Stress-test your plan before writing code (by @mattpocock)\n"
printf "\n"
printf "  a) All skills\n"
printf "  q) Quit\n"
printf "\n"
read -rp "Choice(s) — space-separated (e.g. 1 2): " input

printf "\n"

for choice in $input; do
  case $choice in
    1) install_skill "self-made" "copy-it" ;;
    2) install_skill "community" "grill-me" ;;
    a|A)
      install_skill "self-made" "copy-it"
      install_skill "community" "grill-me"
      ;;
    q|Q) printf "Cancelled.\n"; exit 0 ;;
    *) printf "  Unknown option: %s — skipping\n" "$choice" ;;
  esac
done

printf "\n"
printf "${GREEN}Done!${NC} Restart Claude Code to start using your new skills.\n"
printf "\n"
