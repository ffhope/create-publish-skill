# Skill Development Reference

Complete technical reference for creating and publishing agent skills.

## Table of Contents

1. [Skill Architecture](#skill-architecture)
2. [File Structure](#file-structure)
3. [YAML Frontmatter Specification](#yaml-frontmatter-specification)
4. [Description Writing Guide](#description-writing-guide)
5. [GitHub Repository Setup](#github-repository-setup)
6. [Installation Mechanisms](#installation-mechanisms)
7. [Multi-Skill Repositories](#multi-skill-repositories)
8. [Versioning and Updates](#versioning-and-updates)
9. [Troubleshooting](#troubleshooting)
10. [Best Practices](#best-practices)

---

## Skill Architecture

### Core Components

A skill consists of:

1. **SKILL.md** - Primary instruction file (required)
   - Contains YAML frontmatter with metadata
   - Provides main instructions for the agent
   - Should be concise (< 500 lines recommended)

2. **Reference Files** (optional)
   - `reference.md` - Detailed technical documentation
   - `examples.md` - Concrete usage examples
   - `scripts/` - Executable utility scripts

3. **Repository Files** (optional)
   - `README.md` - Repository documentation
   - `.gitignore` - Git ignore rules
   - `LICENSE` - License file

### Skill Discovery Mechanism

Skills are discovered through:
- GitHub repository structure analysis
- SKILL.md file detection
- YAML frontmatter parsing
- Skills.sh directory indexing

---

## File Structure

### Single Skill Repository

```
skill-name/
├── SKILL.md              # Required
├── README.md             # Recommended
├── reference.md          # Optional - detailed docs
├── examples.md           # Optional - usage examples
├── scripts/              # Optional - utility scripts
│   ├── validate.sh
│   └── helper.py
└── .gitignore            # Optional
```

### Multi-Skill Repository

```
skills-repo/
├── skill-1/
│   ├── SKILL.md
│   ├── reference.md
│   └── examples.md
├── skill-2/
│   ├── SKILL.md
│   └── scripts/
│       └── tool.js
└── README.md
```

---

## YAML Frontmatter Specification

### Required Fields

```yaml
---
name: skill-name
description: Skill description in third person
---
```

### Field Specifications

#### `name` Field

- **Type**: String
- **Required**: Yes
- **Format**: lowercase, hyphens only
- **Length**: Maximum 64 characters
- **Pattern**: `^[a-z0-9-]+$`
- **Examples**:
  - ✅ `react-best-practices`
  - ✅ `python-testing-patterns`
  - ❌ `React_Best_Practices` (uppercase, underscore)
  - ❌ `my-skill!` (invalid character)

#### `description` Field

- **Type**: String
- **Required**: Yes
- **Length**: Maximum 1024 characters
- **Style**: Third person
- **Content**: Must include WHAT and WHEN
- **Format**: Plain text (no markdown in frontmatter)

### Valid Examples

```yaml
---
name: pdf-processor
description: Extracts text and tables from PDF files, fills forms, merges documents. Use when working with PDF files, forms, or document extraction tasks.
---
```

```yaml
---
name: code-review-assistant
description: Reviews code for quality, security, and best practices following team standards. Use when reviewing pull requests, code changes, or when the user asks for a code review.
---
```

---

## Description Writing Guide

### Structure Template

```
[WHAT] + [WHEN] + [TRIGGER KEYWORDS]
```

### Components

1. **WHAT** (Capabilities)
   - What the skill does
   - Key features
   - Output format

2. **WHEN** (Trigger Scenarios)
   - When to use the skill
   - User request patterns
   - Context indicators

3. **Trigger Keywords**
   - Domain-specific terms
   - Technology names
   - Task descriptions

### Writing Checklist

- [ ] Written in third person
- [ ] Includes WHAT (capabilities)
- [ ] Includes WHEN (trigger scenarios)
- [ ] Contains relevant keywords
- [ ] Under 1024 characters
- [ ] No markdown formatting
- [ ] Clear and specific

### Good vs Bad Examples

**Good:**
```
Processes Excel spreadsheets, creates pivot tables, generates charts. Use when analyzing Excel files, spreadsheets, tabular data, or .xlsx files.
```

**Bad:**
```
I can help you with Excel files. (First person, vague)
```

**Good:**
```
Generates descriptive commit messages by analyzing git diffs. Use when the user asks for help writing commit messages or reviewing staged changes.
```

**Bad:**
```
Helps with git. (Too vague, no triggers)
```

---

## GitHub Repository Setup

### Repository Requirements

1. **Visibility**: Must be Public
   - Private repositories cannot be installed via `npx skills add`
   - Public repositories are indexed by skills.sh

2. **Structure**: 
   - Single skill: SKILL.md in root
   - Multi-skill: Each skill in subdirectory

3. **Branch**: 
   - Default branch (usually `main` or `master`)
   - Skills are cloned from default branch

### Repository Creation Methods

#### Method 1: GitHub Web UI

1. Visit https://github.com/new
2. Set repository name
3. Set to Public
4. Initialize with README (optional)
5. Create repository
6. Clone and add SKILL.md

#### Method 2: GitHub CLI

```bash
gh repo create skill-name --public --clone
cd skill-name
# Add SKILL.md
git add .
git commit -m "Add skill"
git push
```

#### Method 3: Git Commands

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/username/skill-name.git
git push -u origin main
```

---

## Installation Mechanisms

### Installation Command Format

```bash
npx skills add <owner>/<repo>[@skill-name]
```

### Single Skill Repository

When repository name matches skill name:

```bash
npx skills add username/skill-name
```

### Multi-Skill Repository

When repository contains multiple skills:

```bash
npx skills add username/repo-name@skill-name
```

### Installation Flags

- `-g, --global` - Install globally (user-level)
- `-y, --yes` - Skip confirmation prompts
- `--list` - List available skills in repository

### Installation Locations

**Global Installation:**
- Path: `~/.agents/skills/skill-name/`
- Scope: Available across all projects

**Project Installation:**
- Path: `.agents/skills/skill-name/`
- Scope: Available only in current project

---

## Multi-Skill Repositories

### Directory Structure

```
multi-skills-repo/
├── skill-a/
│   └── SKILL.md
├── skill-b/
│   ├── SKILL.md
│   └── reference.md
└── README.md
```

### Installation

```bash
# Install skill-a
npx skills add username/multi-skills-repo@skill-a

# Install skill-b
npx skills add username/multi-skills-repo@skill-b
```

### Discovery

Skills are discovered by:
1. Scanning repository for directories
2. Checking each directory for SKILL.md
3. Parsing YAML frontmatter
4. Indexing skill metadata

---

## Versioning and Updates

### Versioning Strategy

Skills don't use semantic versioning in the traditional sense. Instead:

- **Git commits** serve as version history
- **Git tags** can mark releases
- **Branch strategy** for development

### Updating Skills

**For Skill Authors:**

```bash
# Make changes
git add .
git commit -m "Update: Add new features"
git push

# Tag release (optional)
git tag v1.1.0
git push --tags
```

**For Skill Users:**

```bash
# Check for updates
npx skills check

# Update all skills
npx skills update

# Update specific skill
npx skills add owner/repo@skill-name --force
```

### Update Mechanism

1. Skills CLI clones repository
2. Compares with installed version
3. Updates if changes detected
4. Preserves user customizations (if any)

---

## Troubleshooting

### Common Issues

#### Issue: Installation Fails

**Symptoms:**
- Error: "Repository not found"
- Error: "SKILL.md not found"

**Solutions:**
1. Verify repository is Public
2. Check repository name spelling
3. Ensure SKILL.md exists
4. Verify YAML frontmatter format

#### Issue: Skill Not Discovered

**Symptoms:**
- Skill doesn't appear in `npx skills find`
- Installation works but skill not listed

**Solutions:**
1. Wait for indexing (can take minutes)
2. Check skills.sh for listing
3. Verify description contains keywords
4. Ensure repository is public

#### Issue: Description Too Long

**Symptoms:**
- Error during installation
- Skill metadata invalid

**Solutions:**
1. Check description length (< 1024 chars)
2. Remove unnecessary words
3. Focus on key capabilities
4. Use concise language

#### Issue: Name Invalid

**Symptoms:**
- Error: "Invalid skill name"
- Installation rejected

**Solutions:**
1. Use only lowercase letters
2. Use hyphens, not underscores
3. Keep under 64 characters
4. No special characters

---

## Best Practices

### Skill Design

1. **Keep SKILL.md concise** (< 500 lines)
2. **Use progressive disclosure** - Put details in reference.md
3. **Provide examples** - Include examples.md
4. **Add utility scripts** - Put reusable code in scripts/

### Description Writing

1. **Be specific** - Avoid vague terms
2. **Include triggers** - List when skill applies
3. **Use keywords** - Include domain terms
4. **Test discovery** - Verify skill appears in search

### Repository Management

1. **Use descriptive names** - Match skill purpose
2. **Add README** - Help users understand skill
3. **Include examples** - Show usage patterns
4. **Document updates** - Use commit messages

### Testing

1. **Test installation** - Verify `npx skills add` works
2. **Test discovery** - Check `npx skills find`
3. **Test usage** - Verify skill triggers correctly
4. **Test updates** - Ensure updates work

---

## Advanced Topics

### Skill Dependencies

Skills can reference other skills but don't have explicit dependencies. Consider:
- Documenting related skills in README
- Mentioning complementary skills
- Avoiding circular dependencies

### Skill Composition

For complex skills:
- Break into sub-skills
- Use scripts for complex logic
- Reference external documentation
- Provide clear examples

### Performance Considerations

- Keep SKILL.md small (< 500 lines)
- Use reference.md for details
- Minimize script execution time
- Cache expensive operations

---

## API Reference

### Skills CLI Commands

```bash
# Install skill
npx skills add <owner>/<repo>[@skill-name] [flags]

# List installed skills
npx skills list [-g|--global]

# Find skills
npx skills find <query>

# Check for updates
npx skills check

# Update skills
npx skills update

# Remove skill
npx skills remove <skill-name>
```

### Environment Variables

- `SKILLS_NO_TELEMETRY=1` - Disable telemetry
- `DISABLE_TELEMETRY=1` - Disable telemetry (alternative)

---

## Resources

- Skills Directory: https://skills.sh/
- Skills CLI: `npx skills --help`
- GitHub: https://github.com/vercel-labs/skills
- Documentation: https://skills.sh/docs
