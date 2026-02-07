# Skill Structure Overview

## Complete File Structure

```
create-publish-skill/
├── SKILL.md                    # Main skill file (226 lines)
├── README.md                   # Repository documentation
├── reference.md                # Detailed technical reference (500+ lines)
├── examples.md                 # Concrete usage examples (400+ lines)
├── PUBLISH.md                  # Publishing guide
├── STRUCTURE.md                # This file
├── .gitignore                  # Git ignore rules
├── publish.sh                  # Publishing script (GitHub CLI)
├── publish-with-token.sh       # Publishing script (with token)
└── scripts/
    ├── validate-skill.sh       # Validates SKILL.md format
    ├── generate-skill.sh       # Generates new skill template
    ├── publish-skill.sh        # Publishes skill to GitHub
    └── check-skill-structure.sh # Checks skill directory structure
```

## File Purposes

### Core Files

- **SKILL.md** - Main instruction file with YAML frontmatter
  - Contains quick reference and links to detailed docs
  - Progressive disclosure pattern

- **reference.md** - Complete technical reference
  - Skill architecture details
  - YAML frontmatter specification
  - Description writing guide
  - GitHub repository setup
  - Troubleshooting guide
  - Best practices

- **examples.md** - Concrete usage examples
  - 10+ complete examples
  - Single skill repository
  - Multi-skill repository
  - Skills with scripts
  - Publishing workflows

### Utility Scripts

- **validate-skill.sh** - Validates SKILL.md format
  - Checks YAML frontmatter
  - Validates name and description
  - Checks file size

- **generate-skill.sh** - Generates skill template
  - Creates directory structure
  - Generates SKILL.md template
  - Creates README.md and .gitignore

- **publish-skill.sh** - Publishes skill to GitHub
  - Validates skill
  - Creates GitHub repository
  - Pushes code

- **check-skill-structure.sh** - Checks skill structure
  - Verifies required files
  - Lists optional files
  - Checks git status

## Usage

### Validate Skill

```bash
./scripts/validate-skill.sh SKILL.md
```

### Generate New Skill

```bash
./scripts/generate-skill.sh my-skill "Description here"
```

### Check Structure

```bash
./scripts/check-skill-structure.sh .
```

### Publish Skill

```bash
./scripts/publish-skill.sh . username token
```

## Statistics

- **Total files**: 12
- **Scripts**: 4
- **Documentation**: 5 files
- **Total lines**: 2000+ lines of documentation
