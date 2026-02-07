#!/bin/bash

SKILL_DIR="${1:-.}"

echo "📋 Checking skill structure: $SKILL_DIR"
echo ""

cd "$SKILL_DIR"

# Check required files
echo "Required files:"
if [ -f "SKILL.md" ]; then
    echo "  ✅ SKILL.md"
else
    echo "  ❌ SKILL.md (MISSING)"
fi

# Check recommended files
echo ""
echo "Recommended files:"
[ -f "README.md" ] && echo "  ✅ README.md" || echo "  ⚠️  README.md (recommended)"
[ -f ".gitignore" ] && echo "  ✅ .gitignore" || echo "  ⚠️  .gitignore (recommended)"

# Check optional files
echo ""
echo "Optional files:"
[ -f "reference.md" ] && echo "  ✅ reference.md" || echo "  ⚠️  reference.md (optional)"
[ -f "examples.md" ] && echo "  ✅ examples.md" || echo "  ⚠️  examples.md (optional)"
[ -d "scripts" ] && echo "  ✅ scripts/ ($(ls scripts/ 2>/dev/null | wc -l | tr -d ' ') files)" || echo "  ⚠️  scripts/ (optional)"

# Check file sizes
echo ""
echo "File sizes:"
if [ -f "SKILL.md" ]; then
    LINES=$(wc -l < SKILL.md)
    if [ "$LINES" -gt 500 ]; then
        echo "  ⚠️  SKILL.md: $LINES lines (consider using reference.md for details)"
    else
        echo "  ✅ SKILL.md: $LINES lines"
    fi
fi

# Check git status
echo ""
echo "Git status:"
if [ -d ".git" ]; then
    echo "  ✅ Git repository initialized"
    if git remote | grep -q origin; then
        REMOTE=$(git remote get-url origin)
        echo "  ✅ Remote: $REMOTE"
    else
        echo "  ⚠️  No remote configured"
    fi
else
    echo "  ⚠️  Not a git repository"
fi

echo ""
echo "✅ Structure check complete"
