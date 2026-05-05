$SkillsDir = "$env:USERPROFILE\.claude\skills"
$Repo = "DoritosXL/claude-skills"
$BaseUrl = "https://raw.githubusercontent.com/$Repo/main"

Write-Host ""
Write-Host "Claude Skills Installer" -ForegroundColor Blue
Write-Host "github.com/$Repo"
Write-Host ""

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null

function Install-Skill {
  param([string]$Category, [string]$Skill)
  $skillDir = "$SkillsDir\$Skill"
  New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
  Invoke-WebRequest -Uri "$BaseUrl/$Category/$Skill/SKILL.md" -OutFile "$skillDir\SKILL.md" -UseBasicParsing
  Write-Host "  v $Skill" -ForegroundColor Green
}

Write-Host "Self-made skills:" -ForegroundColor White
Write-Host "  1) copy-it    - Clone any website into a working codebase"
Write-Host ""
Write-Host "Community skills:" -ForegroundColor White
Write-Host "  2) grill-me   - Stress-test your plan before writing code (by @mattpocock)"
Write-Host ""
Write-Host "  a) All skills"
Write-Host "  q) Quit"
Write-Host ""
$input = Read-Host "Choice(s) - space-separated (e.g. 1 2)"

Write-Host ""

foreach ($choice in $input.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)) {
  switch ($choice.Trim()) {
    "1" { Install-Skill "self-made" "copy-it" }
    "2" { Install-Skill "community" "grill-me" }
    { $_ -in "a","A" } {
      Install-Skill "self-made" "copy-it"
      Install-Skill "community" "grill-me"
    }
    { $_ -in "q","Q" } { Write-Host "Cancelled."; exit 0 }
    default { Write-Host "  Unknown option: $choice - skipping" }
  }
}

Write-Host ""
Write-Host "Done! Restart Claude Code to start using your new skills." -ForegroundColor Green
Write-Host ""
