# Skill Template: Commit Helper

## Purpose

Generate commit messages by learning project's commit message conventions.

## Instructions for Claude

When this skill is invoked:

### Step 1: Analyze Recent Commits
1. Read last 10-20 commit messages in git log
2. Identify patterns:
   - Message structure (conventional commits? free form?)
   - Common prefixes (feat:, fix:, chore:, etc.)
   - Length conventions (short? detailed?)
   - Multi-line format (body? footer?)
   - Issue reference style (#123, JIRA-123, etc.)

### Step 2: Learn Project Conventions
Extract from commit history:
- Subject line format
- Use of present tense vs past tense
- Capitalization style
- Special markers or tags
- Co-author patterns
- Breaking change indicators

### Step 3: Analyze Changes
- Read git diff (staged changes)
- Categorize changes:
  - New feature?
  - Bug fix?
  - Refactoring?
  - Documentation?
  - Tests?
  - Configuration?
- Identify affected components/modules

### Step 4: Generate Message
Create commit message following learned conventions:
- Match project's structure
- Use appropriate prefix/type
- Describe what changed and why
- Include issue references if project uses them
- Add body/footer if project convention requires

## What to Learn

### Message Structure
```
From: git log --oneline -20
Learn: Format pattern? Conventional commits? Custom format?
```

### Prefixes/Types
```
From: Common commit message starts
Learn: feat/fix/chore? Custom tags? No prefix?
```

### Detail Level
```
From: Commit message length
Learn: Short one-liners? Detailed descriptions? Body text?
```

### Issue References
```
From: Commit messages with #, JIRA-, etc.
Learn: How are issues referenced? Where (subject/body)?
```

### Special Conventions
```
From: Unique patterns in commits
Learn: Co-authored-by? Breaking change markers? Other?
```

## Example Adaptation

**Project with conventional commits**:
```
Learned from git log:
- Uses "feat:", "fix:", "chore:"
- Subject line < 72 chars
- Sometimes includes JIRA-XXX reference

Generated:
feat: add export validation for CCPA data

Validates PII fields before export to ensure compliance.

JIRA-1234
```

**Project with free-form commits**:
```
Learned from git log:
- Descriptive sentences
- Usually includes affected component
- Sometimes multi-line with details

Generated:
Export Service: Add validation for CCPA data exports

Added validation logic to check PII fields before initiating
export jobs. This ensures compliance with privacy requirements
before data leaves the system.
```

## Usage

`/commit`

Claude will:
1. Read this template
2. Analyze project's commit history
3. Learn commit message conventions
4. Read git diff
5. Generate commit message matching project style

Developer can then:
- Accept as-is
- Edit before committing
- Regenerate if not satisfied