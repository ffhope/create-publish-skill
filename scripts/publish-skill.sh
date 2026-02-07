#!/bin/bash

set -e

SKILL_DIR="${1:-.}"
GITHUB_USER="${2:-}"
GITHUB_TOKEN="${3:-$GITHUB_TOKEN}"

if [ -z "$GITHUB_USER" ]; then
    echo "Usage: publish-skill.sh [skill-directory] <github-username> [github-token]"
    echo ""
    echo "Example:"
    echo "  ./publish-skill.sh . username token"
    echo "  GITHUB_TOKEN=token ./publish-skill.sh . username"
    exit 1
fi

cd "$SKILL_DIR"

# Validate SKILL.md exists
if [ ! -f "SKILL.md" ]; then
    echo "❌ Error: SKILL.md not found in $SKILL_DIR"
    exit 1
fi

# Extract skill name from SKILL.md
SKILL_NAME=$(grep "^name:" SKILL.md | head -1 | cut -d' ' -f2 | tr -d '"' | tr -d "'" | tr -d ' ')

if [ -z "$SKILL_NAME" ]; then
    echo "❌ Error: Could not extract skill name from SKILL.md"
    exit 1
fi

echo "📦 Publishing skill: $SKILL_NAME"
echo "👤 GitHub user: $GITHUB_USER"

# Validate skill
if [ -f "scripts/validate-skill.sh" ]; then
    echo "🔍 Validating skill..."
    bash scripts/validate-skill.sh SKILL.md
fi

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo "📝 Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: Add $SKILL_NAME"
fi

# Check if remote exists
if git remote | grep -q origin; then
    echo "📍 Remote already exists"
    git remote set-url origin "https://github.com/$GITHUB_USER/$SKILL_NAME.git"
else
    echo "📍 Adding remote..."
    git remote add origin "https://github.com/$GITHUB_USER/$SKILL_NAME.git"
fi

# Create GitHub repository if needed
if [ -n "$GITHUB_TOKEN" ]; then
    export GH_TOKEN="$GITHUB_TOKEN"
    
    # Check if repo exists
    if gh repo view "$GITHUB_USER/$SKILL_NAME" &>/dev/null; then
        echo "📦 Repository already exists"
    else
        echo "📦 Creating GitHub repository..."
        gh repo create "$SKILL_NAME" --public --source=. --remote=origin --push 2>/dev/null || true
    fi
fi

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git add .
git commit -m "Update: $SKILL_NAME" 2>/dev/null || echo "No changes to commit"
git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null || {
    echo "⚠️  Push failed. You may need to:"
    echo "   1. Create repository manually: https://github.com/new"
    echo "   2. Or set GITHUB_TOKEN environment variable"
}

echo ""
echo "✅ Skill published!"
echo ""
echo "📍 Repository: https://github.com/$GITHUB_USER/$SKILL_NAME"
echo "📍 Skill page: https://skills.sh/$GITHUB_USER/$SKILL_NAME"
echo ""
echo "Install command:"
echo "  npx skills add $GITHUB_USER/$SKILL_NAME"
