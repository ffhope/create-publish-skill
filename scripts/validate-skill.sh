#!/bin/bash

set -e

SKILL_FILE="${1:-SKILL.md}"
ERRORS=0

echo "🔍 Validating skill: $SKILL_FILE"

# Check if SKILL.md exists
if [ ! -f "$SKILL_FILE" ]; then
    echo "❌ Error: $SKILL_FILE not found"
    exit 1
fi

# Check YAML frontmatter start
if ! head -1 "$SKILL_FILE" | grep -q "^---$"; then
    echo "❌ Error: Missing YAML frontmatter start (---)"
    ERRORS=$((ERRORS + 1))
fi

# Check YAML frontmatter end
if ! sed -n '2,10p' "$SKILL_FILE" | grep -q "^---$"; then
    echo "❌ Error: Missing YAML frontmatter end (---)"
    ERRORS=$((ERRORS + 1))
fi

# Extract frontmatter (between first two --- lines)
FRONTMATTER=$(awk '/^---$/{if(++c==2)exit} c==1' "$SKILL_FILE")

# Check name field
if ! echo "$FRONTMATTER" | grep -q "^name:"; then
    echo "❌ Error: Missing 'name' field"
    ERRORS=$((ERRORS + 1))
else
    NAME=$(echo "$FRONTMATTER" | grep "^name:" | cut -d' ' -f2 | tr -d '"' | tr -d "'")
    
    # Validate name format
    if ! echo "$NAME" | grep -qE '^[a-z0-9-]+$'; then
        echo "❌ Error: Invalid name format. Use lowercase, hyphens only: $NAME"
        ERRORS=$((ERRORS + 1))
    fi
    
    # Check name length
    if [ ${#NAME} -gt 64 ]; then
        echo "❌ Error: Name too long (max 64 chars): $NAME"
        ERRORS=$((ERRORS + 1))
    fi
fi

# Check description field
if ! echo "$FRONTMATTER" | grep -q "^description:"; then
    echo "❌ Error: Missing 'description' field"
    ERRORS=$((ERRORS + 1))
else
    DESCRIPTION=$(echo "$FRONTMATTER" | grep "^description:" | cut -d' ' -f2- | tr -d '"' | tr -d "'")
    
    # Check description length
    if [ ${#DESCRIPTION} -gt 1024 ]; then
        echo "❌ Error: Description too long (max 1024 chars): ${#DESCRIPTION} chars"
        ERRORS=$((ERRORS + 1))
    fi
    
    # Check for third person (basic check)
    if echo "$DESCRIPTION" | grep -qiE "^(I|You|We) "; then
        echo "⚠️  Warning: Description might not be in third person"
    fi
fi

# Check file size (recommendation)
FILE_LINES=$(wc -l < "$SKILL_FILE")
if [ "$FILE_LINES" -gt 500 ]; then
    echo "⚠️  Warning: SKILL.md is large ($FILE_LINES lines). Consider using reference.md for details."
fi

if [ $ERRORS -eq 0 ]; then
    echo "✅ Skill validation passed!"
    exit 0
else
    echo "❌ Validation failed with $ERRORS error(s)"
    exit 1
fi
