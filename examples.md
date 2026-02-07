# Skill Creation Examples

Concrete examples of creating and publishing skills.

## Example 1: Simple Single Skill

### Scenario
Create a skill for React best practices.

### Step 1: Create SKILL.md

```markdown
---
name: react-best-practices
description: Provides React best practices and patterns. Use when building React components, optimizing React apps, or when the user asks about React performance, hooks, or component design.
---

# React Best Practices

## Component Design
- Use functional components
- Extract reusable logic to custom hooks
- Keep components small and focused

## Performance
- Use React.memo for expensive components
- Implement useMemo for expensive calculations
- Use useCallback for stable function references
```

### Step 2: Create Repository

```bash
mkdir react-best-practices
cd react-best-practices
echo "# React Best Practices Skill" > README.md
# Add SKILL.md
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/username/react-best-practices.git
git push -u origin main
```

### Step 3: Install

```bash
npx skills add username/react-best-practices
```

---

## Example 2: Skill with Reference and Examples

### Scenario
Create a comprehensive PDF processing skill.

### Directory Structure

```
pdf-processor/
├── SKILL.md
├── README.md
├── reference.md
├── examples.md
└── scripts/
    └── validate-pdf.sh
```

### SKILL.md (Concise)

```markdown
---
name: pdf-processor
description: Extracts text and tables from PDF files, fills forms, merges documents. Use when working with PDF files, forms, or document extraction tasks.
---

# PDF Processor

Quick reference for PDF processing tasks.

For detailed API documentation, see [reference.md](reference.md).
For usage examples, see [examples.md](examples.md).

## Quick Start

1. Extract text: Use pdfplumber
2. Fill forms: Use PyPDF2
3. Merge documents: Use pypdf
```

### reference.md (Detailed)

```markdown
# PDF Processing Reference

## Libraries

### pdfplumber
- Best for: Text extraction, table extraction
- Installation: `pip install pdfplumber`
- Performance: Good for structured PDFs

### PyPDF2
- Best for: Form filling, metadata
- Installation: `pip install PyPDF2`
- Performance: Moderate

## API Reference
...
```

### examples.md (Concrete)

```markdown
# PDF Processing Examples

## Extract Text

```python
import pdfplumber

with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

## Fill Form

```python
from PyPDF2 import PdfReader, PdfWriter

reader = PdfReader("form.pdf")
writer = PdfWriter()
# Fill form fields
writer.write("filled.pdf")
```
```

---

## Example 3: Multi-Skill Repository

### Scenario
Create a repository with multiple testing-related skills.

### Directory Structure

```
testing-skills/
├── jest-patterns/
│   └── SKILL.md
├── playwright-guide/
│   ├── SKILL.md
│   └── examples.md
├── e2e-best-practices/
│   ├── SKILL.md
│   └── reference.md
└── README.md
```

### Installation

```bash
# Install Jest patterns
npx skills add username/testing-skills@jest-patterns

# Install Playwright guide
npx skills add username/testing-skills@playwright-guide

# Install E2E best practices
npx skills add username/testing-skills@e2e-best-practices
```

---

## Example 4: Skill with Utility Scripts

### Scenario
Create a skill with validation and helper scripts.

### Directory Structure

```
api-design-skill/
├── SKILL.md
├── reference.md
└── scripts/
    ├── validate-openapi.sh
    ├── generate-client.py
    └── check-endpoints.js
```

### SKILL.md Reference

```markdown
## Utility Scripts

**validate-openapi.sh**: Validates OpenAPI specification
```bash
./scripts/validate-openapi.sh api.yaml
```

**generate-client.py**: Generates API client code
```bash
python scripts/generate-client.py --spec api.yaml --lang typescript
```
```

### Script Example: validate-openapi.sh

```bash
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: validate-openapi.sh <openapi-file>"
    exit 1
fi

# Validate using swagger-parser
npx @apidevtools/swagger-parser validate "$1"

if [ $? -eq 0 ]; then
    echo "✅ OpenAPI spec is valid"
else
    echo "❌ OpenAPI spec has errors"
    exit 1
fi
```

---

## Example 5: Complex Skill with Progressive Disclosure

### Scenario
Create a comprehensive DevOps skill with multiple components.

### SKILL.md (Main - Concise)

```markdown
---
name: devops-automation
description: Provides DevOps automation patterns, CI/CD templates, and infrastructure as code examples. Use when setting up CI/CD pipelines, deploying applications, or working with infrastructure automation.
---

# DevOps Automation

Quick reference for DevOps tasks.

## Quick Links

- [CI/CD Patterns](reference.md#cicd-patterns)
- [Infrastructure as Code](reference.md#iac)
- [Examples](examples.md)
- [Scripts](scripts/)

## Common Tasks

1. **Setup CI/CD**: See GitHub Actions templates
2. **Deploy to Cloud**: See Terraform examples
3. **Monitor Services**: See Prometheus configs
```

### reference.md (Detailed)

```markdown
# DevOps Automation Reference

## CI/CD Patterns

### GitHub Actions

[Detailed GitHub Actions patterns...]

### GitLab CI

[Detailed GitLab CI patterns...]

## Infrastructure as Code

### Terraform

[Detailed Terraform patterns...]

### Ansible

[Detailed Ansible patterns...]
```

### examples.md (Concrete)

```markdown
# DevOps Automation Examples

## GitHub Actions Workflow

```yaml
name: CI
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm test
```
```

---

## Example 6: Skill with Conditional Logic

### Scenario
Create a skill that adapts based on project type.

### SKILL.md

```markdown
---
name: project-scaffolder
description: Scaffolds new projects with best practices. Use when creating new projects, setting up project structure, or when the user asks for project templates.
---

# Project Scaffolder

## Determine Project Type

1. **Web Application** → Use React/Next.js template
2. **API Service** → Use FastAPI/Express template
3. **CLI Tool** → Use Python/Node.js template

## Scaffolding Steps

[Detailed steps for each type...]
```

---

## Example 7: Skill with External Dependencies

### Scenario
Create a skill that uses external tools.

### SKILL.md

```markdown
---
name: database-migrator
description: Generates and runs database migrations. Use when working with database schema changes, migrations, or when the user mentions database updates.
---

# Database Migrator

## Prerequisites

- Python 3.8+
- Alembic (for SQLAlchemy)
- Or Django migrations (for Django)

## Usage

See [examples.md](examples.md) for framework-specific examples.
```

### examples.md

```markdown
# Database Migration Examples

## SQLAlchemy + Alembic

```bash
# Generate migration
alembic revision --autogenerate -m "Add user table"

# Apply migration
alembic upgrade head
```

## Django

```bash
# Generate migration
python manage.py makemigrations

# Apply migration
python manage.py migrate
```
```

---

## Example 8: Skill with Validation

### Scenario
Create a skill with built-in validation.

### scripts/validate-skill.sh

```bash
#!/bin/bash

SKILL_FILE="SKILL.md"

# Check if SKILL.md exists
if [ ! -f "$SKILL_FILE" ]; then
    echo "❌ SKILL.md not found"
    exit 1
fi

# Check YAML frontmatter
if ! grep -q "^---$" "$SKILL_FILE"; then
    echo "❌ Missing YAML frontmatter"
    exit 1
fi

# Check name field
if ! grep -q "^name:" "$SKILL_FILE"; then
    echo "❌ Missing name field"
    exit 1
fi

# Check description field
if ! grep -q "^description:" "$SKILL_FILE"; then
    echo "❌ Missing description field"
    exit 1
fi

echo "✅ Skill validation passed"
```

---

## Example 9: Skill Template Generator

### Scenario
Create a script that generates skill templates.

### scripts/generate-skill.sh

```bash
#!/bin/bash

SKILL_NAME=$1

if [ -z "$SKILL_NAME" ]; then
    echo "Usage: generate-skill.sh <skill-name>"
    exit 1
fi

mkdir -p "$SKILL_NAME"

cat > "$SKILL_NAME/SKILL.md" << EOF
---
name: $SKILL_NAME
description: [Describe what this skill does and when to use it]
---

# $(echo $SKILL_NAME | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')

## Instructions
[Add instructions here]

## Examples
[Add examples here]
EOF

echo "✅ Skill template created: $SKILL_NAME/"
```

---

## Example 10: Publishing Workflow

### Complete Publishing Example

```bash
#!/bin/bash
# Complete workflow for creating and publishing a skill

SKILL_NAME="my-new-skill"
GITHUB_USER="username"
GITHUB_TOKEN="your_token"

# 1. Create skill directory
mkdir "$SKILL_NAME"
cd "$SKILL_NAME"

# 2. Create SKILL.md
cat > SKILL.md << 'EOF'
---
name: my-new-skill
description: [Description here]
---

# My New Skill
[Content here]
EOF

# 3. Create README.md
echo "# $SKILL_NAME" > README.md

# 4. Initialize git
git init
git add .
git commit -m "Initial commit: Add $SKILL_NAME"

# 5. Create GitHub repository
gh repo create "$SKILL_NAME" --public --source=. --remote=origin

# 6. Push to GitHub
git push -u origin main

# 7. Install locally
npx skills add "$GITHUB_USER/$SKILL_NAME"

echo "✅ Skill created and published!"
```

---

## Testing Examples

### Test Skill Installation

```bash
# Test installation
npx skills add username/skill-name

# Verify installation
npx skills list -g | grep skill-name

# Test skill content
cat ~/.agents/skills/skill-name/SKILL.md
```

### Test Skill Discovery

```bash
# Search for skill
npx skills find "your keywords"

# Should show your skill in results
```

### Test Skill Usage

In Cursor, test with prompts like:
- "How do I [skill purpose]?"
- "Help me with [skill domain]"
- "[Trigger keywords from description]"
