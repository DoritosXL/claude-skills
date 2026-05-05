#!/usr/bin/env bash
set -e

SKILLS_DIR="$HOME/.claude/skills"
REPO="DoritosXL/claude-skills"
BASE_URL="https://raw.githubusercontent.com/$REPO/main"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${BOLD}${BLUE}Claude Skills Installer${NC}"
echo -e "github.com/$REPO"
echo ""

mkdir -p "$SKILLS_DIR"

install_skill() {
  local category=$1
  local skill=$2
  local skill_dir="$SKILLS_DIR/$skill"

  mkdir -p "$skill_dir"
  curl -fsSL "$BASE_URL/$category/$skill/SKILL.md" -o "$skill_dir/SKILL.md"
  echo -e "  ${GREEN}✓${NC} $skill"
}

echo -e "${BOLD}Self-made skills:${NC}"
echo "  1) copy-it    — Clone any website into a working codebase"
echo ""
echo -e "${BOLD}Community skills:${NC}"
echo "  2) grill-me   — Stress-test your plan before writing code (by @mattpocock)"
echo ""
echo "  a) All skills"
echo "  q) Quit"
echo ""
read -rp "Choice(s) — space-separated (e.g. 1 2): " input

echo ""

for choice in $input; do
  case $choice in
    1) install_skill "self-made" "copy-it" ;;
    2) install_skill "community" "grill-me" ;;
    a|A)
      install_skill "self-made" "copy-it"
      install_skill "community" "grill-me"
      ;;
    q|Q) echo "Cancelled."; exit 0 ;;
    *) echo "  Unknown option: $choice — skipping" ;;
  esac
done

echo ""
echo -e "${GREEN}Done!${NC} Restart Claude Code to start using your new skills."
echo ""
