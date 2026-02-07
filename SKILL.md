---
name: create-publish-skill
description: Guides users through creating and publishing agent skills to GitHub. Use when users want to create new skills, publish skills, understand skill structure, set up skill repositories, or ask about skill development workflow. Provides step-by-step instructions for creating SKILL.md files, setting up GitHub repositories, and making skills installable via npx skills add.
---

# Create and Publish Skills

Complete guide for creating and publishing agent skills to GitHub for installation via `npx skills add`.

## When to Use This Skill

Use this skill when:
- Creating new skills for Cursor or other agents
- Publishing skills to GitHub
- Understanding skill structure and requirements
- Setting up skill repositories
- Troubleshooting skill installation issues

## Skill Structure Requirements

### Required Files

Every skill must have:

1. **SKILL.md** - Main instruction file with YAML frontmatter (required)
2. **README.md** - Repository documentation (recommended)
3. Optional files:
   - `reference.md` - Detailed documentation
   - `examples.md` - Usage examples
   - `scripts/` - Utility scripts

### SKILL.md Format

```markdown
---
name: your-skill-name
description: Brief description in third person. Include WHAT it does and WHEN to use it. Max 1024 chars.
---

# Your Skill Name

## Instructions
Clear, step-by-step guidance for the agent.

## Examples
Concrete examples of using this skill.
```

## Required Metadata Fields

| Field | Requirements | Purpose |
|-------|--------------|---------|
| `name` | Max 64 chars, lowercase letters/numbers/hyphens only | Unique identifier |
| `description` | Max 1024 chars, third person, include WHAT and WHEN | Helps agent decide when to apply |

### Description Best Practices

1. **Write in third person**:
   - ✅ Good: "Processes Excel files and generates reports"
   - ❌ Bad: "I can help you process Excel files"

2. **Be specific and include trigger terms**:
   - ✅ Good: "Extract text from PDF files. Use when working with PDFs, forms, or document extraction."
   - ❌ Bad: "Helps with documents"

3. **Include both WHAT and WHEN**:
   - WHAT: What the skill does
   - WHEN: When the agent should use it (trigger scenarios)

## Publishing Steps

### Step 1: Create GitHub Repository

1. Visit https://github.com/new
2. Repository name: `your-skill-name` (or your skill name)
3. Set to **Public** (required - private repos cannot be installed)
4. Add README.md (optional)
5. Create repository

### Step 2: Prepare Skill Files

Ensure your skill directory contains:

```
your-skill-name/
├── SKILL.md          # Required
├── README.md         # Recommended
└── Other files (optional)
```

### Step 3: Push to GitHub

```bash
# Initialize git (if not already)
git init

# Add files
git add .

# Commit
git commit -m "Initial commit: Add skill files"

# Add remote repository (replace with your username)
git remote add origin https://github.com/your-username/your-skill-name.git

# Push to GitHub
git push -u origin main
```

### Step 4: Install and Test

```bash
# Single skill repository (repo name = skill name)
npx skills add your-username/your-skill-name

# Or specify skill name explicitly
npx skills add your-username/your-skill-name@your-skill-name
```

### Step 5: Verify Installation

```bash
# List installed skills
npx skills list -g | grep your-skill-name

# View skill content
cat ~/.agents/skills/your-skill-name/SKILL.md
```

## Multi-Skill Repository

If your repository contains multiple skills:

```
my-skills-repo/
├── skill-1/
│   └── SKILL.md
├── skill-2/
│   └── SKILL.md
└── README.md
```

Install specific skills:
```bash
npx skills add your-username/my-skills-repo@skill-1
npx skills add your-username/my-skills-repo@skill-2
```

## Critical Requirements Checklist

Before publishing, verify:

- [ ] Repository is **Public** (private repos won't work)
- [ ] SKILL.md file exists
- [ ] YAML frontmatter present (name + description)
- [ ] `name` field: lowercase, hyphens, max 64 chars
- [ ] `description` field: third person, includes WHAT and WHEN, max 1024 chars
- [ ] Files committed and pushed to GitHub

## After Publishing

Once published to GitHub:

1. Skill automatically appears at: https://skills.sh/your-username/your-skill-name
2. Users can discover it via: `npx skills find your-keywords`
3. Users can install it via: `npx skills add your-username/your-skill-name`

## Updating Skills

```bash
# Make changes to files
git add .
git commit -m "Update skill"
git push

# Users update with
npx skills update
```

## Common Issues

### Installation Fails

- Check repository is Public
- Verify SKILL.md exists
- Check YAML frontmatter format
- Ensure name follows naming rules

### Skill Not Found

- Verify repository name is correct
- Check skill name matches (for multi-skill repos)
- Wait a few minutes for indexing

### Description Too Long

- Keep under 1024 characters
- Focus on key capabilities and triggers
- Remove unnecessary words

## Example Skill Template

See the complete example in the repository for a working template.
