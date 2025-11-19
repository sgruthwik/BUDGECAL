<#
Simple PowerShell helper to initialize a Git repo for this project and push to GitHub.
Run this from the project folder (where Budge.html is):
  cd "r:\BTECH\FSD\FSD PROJECT"
  .\deploy_github_pages.ps1

This script will:
 - check for git
 - create a local commit if none exists
 - optionally use GitHub CLI (gh) to create and push a new repo
If you don't have gh, the script will print the manual commands to add a remote and push.
#>

param(
  [switch]$UseGh
)

function ExitWith($msg){ Write-Host $msg -ForegroundColor Red; exit 1 }

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { ExitWith "Git is not installed or not in PATH. Install Git first: https://git-scm.com/downloads" }

# ensure we're in the project directory
$pwdPath = Get-Location
Write-Host "Working directory: $pwdPath"

# Init git if needed
if (-not (Test-Path .git)) {
  git init | Out-Null
  Write-Host "Initialized new git repository."
}

# Create a commit if none exists
$hasCommit = git rev-parse --verify HEAD 2>$null
if ($LASTEXITCODE -ne 0) {
  git add .
  git commit -m "Initial commit: Budge site" 2>$null
  Write-Host "Created initial commit."
} else {
  Write-Host "Repository already has commits."
}

# Try to use gh CLI if available or requested
$ghExists = (Get-Command gh -ErrorAction SilentlyContinue) -ne $null
if ($UseGh -and -not $ghExists) {
  Write-Host "You passed -UseGh but 'gh' (GitHub CLI) is not installed. Install: https://cli.github.com/" -ForegroundColor Yellow
}

if ($ghExists -or $UseGh) {
  if (-not $ghExists) { ExitWith "GitHub CLI is not available. Install and re-run with -UseGh or follow the manual steps in DEPLOY.md." }

  Write-Host "Using GitHub CLI to create repository..."
  $repoName = Read-Host "Repository name to create on GitHub (e.g. budge-site)"
  if (-not $repoName) { ExitWith "No repository name provided." }

  # Create repo and push
  try {
    gh repo create $repoName --public --source="." --remote=origin --push --confirm
    Write-Host "Repository created and pushed. Visit: https://github.com/<your-username>/$repoName" -ForegroundColor Green
    Write-Host "To enable GitHub Pages: go to the repo Settings -> Pages and set source to 'main' (root)." -ForegroundColor Cyan
  } catch {
    Write-Host "gh command failed: $_" -ForegroundColor Red
    Write-Host "If the repo already exists, run the manual push commands listed in DEPLOY.md." -ForegroundColor Yellow
  }
} else {
  Write-Host "gh CLI not used. To push to GitHub manually, run these commands (replace <username> and <repo>):" -ForegroundColor Cyan
  Write-Host "git branch -M main"
  Write-Host "git remote add origin https://github.com/<username>/<repo>.git"
  Write-Host "git push -u origin main"
  Write-Host "After pushing, enable Pages in the repo Settings -> Pages (select main / root)."
}

Write-Host "Done." -ForegroundColor Green
