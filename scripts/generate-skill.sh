#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage: generate-skill.sh <skill-name> [description]"
    echo ""
    echo "Example:"
    echo "  ./generate-skill.sh my-skill \"Processes files and generates reports\""
    exit 1
fi

SKILL_NAME="$1"
DESCRIPTION="${2:-Add description here. Use when...}"

# Validate skill name
if ! echo "$SKILL_NAME" | grep -qE '^[a-z0-9-]+$'; then
    echo "❌ Error: Invalid skill name. Use lowercase, hyphens only."
    echo "   Got: $SKILL_NAME"
    exit 1
fi

if [ ${#SKILL_NAME} -gt 64 ]; then
    echo "❌ Error: Skill name too long (max 64 chars)"
    exit 1
fi

echo "📦 Generating skill: $SKILL_NAME"

# Create directory
mkdir -p "$SKILL_NAME"
cd "$SKILL_NAME"

# Generate SKILL.md
cat > SKILL.md << EOF
---
name: $SKILL_NAME
description: $DESCRIPTION
---

# $(echo $SKILL_NAME | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')

## When to Use This Skill

Use this skill when:
- [Add trigger scenario 1]
- [Add trigger scenario 2]
- [Add trigger scenario 3]

## Instructions

[Add clear, step-by-step guidance for the agent]

## Examples

[Add concrete examples of using this skill]

## Additional Resources

- For detailed documentation, see [reference.md](reference.md) (if exists)
- For more examples, see [examples.md](examples.md) (if exists)
EOF

# Generate README.md
cat > README.md << EOF
# $SKILL_NAME

[Brief description of what this skill does]

## Installation

\`\`\`bash
npx skills add your-username/$SKILL_NAME
\`\`\`

## Usage

[Usage instructions]

## Files

- \`SKILL.md\` - Main skill file
- \`README.md\` - This file
- \`reference.md\` - Detailed documentation (optional)
- \`examples.md\` - Usage examples (optional)
EOF

# Generate .gitignore
cat > .gitignore << EOF
# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo

# Dependencies
node_modules/
venv/
__pycache__/

# Build
dist/
build/
*.log
EOF

echo "✅ Skill template created!"
echo ""
echo "📁 Directory: $SKILL_NAME/"
echo "📄 Files created:"
echo "   - SKILL.md"
echo "   - README.md"
echo "   - .gitignore"
echo ""
echo "Next steps:"
echo "  1. Edit SKILL.md with your skill content"
echo "  2. Add reference.md and examples.md (optional)"
echo "  3. Initialize git: git init"
echo "  4. Create GitHub repo and push"
