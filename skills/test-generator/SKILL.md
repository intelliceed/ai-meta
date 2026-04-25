# Skill Template: Test Generator

## Purpose

Generate tests for Python code by learning from existing test patterns in the project.

## Instructions for Claude

When this skill is invoked:

### Step 1: Analyze Existing Tests
1. Find test directory (usually `tests/`, `test/`)
2. Read 3-5 existing test files
3. Identify:
   - Testing framework (pytest, unittest, etc.)
   - Test file naming convention
   - Import patterns
   - Fixture definitions and usage
   - Mocking strategies
   - Assertion styles
   - Test function naming

### Step 2: Learn Project-Specific Patterns
Extract from existing tests:
- How fixtures are defined (decorator, scope, return type)
- How external dependencies are mocked (boto3, databases, APIs)
- Test data structure (inline, fixtures, separate files)
- Async patterns (if used)
- Custom decorators or utilities
- Test organization (classes, functions, grouping)

### Step 3: Identify Target Code
- Read the file/function to be tested
- Identify public functions/methods
- Note dependencies (external services, databases, file I/O)
- Identify error conditions and edge cases

### Step 4: Generate Tests
Create test file following learned patterns:
- Match file naming convention
- Use same imports structure
- Define fixtures matching project style
- Mock dependencies using project's approach
- Write test functions for:
  - Happy path (successful execution)
  - Error conditions
  - Edge cases (empty input, None, boundary values)
  - External dependency failures
- Use same assertion style

### Step 5: Verify
- Ensure imports are correct
- Check test can run (no syntax errors)
- Verify mocks match project's mocking library

## What to Learn

### Testing Framework
```
From: import statements, decorators
Learn: pytest? unittest? Other?
```

### Fixtures
```
From: @pytest.fixture or similar
Learn: How are reusable test data/mocks defined?
```

### Mocking Strategy
```
From: unittest.mock, pytest-mock, or other
Learn: How are external dependencies mocked?
```

### Test Structure
```
From: Test file organization
Learn: Classes? Plain functions? Grouping style?
```

### Naming Conventions
```
From: Existing test names
Learn: test_*, Test*, naming pattern?
```

## Example Adaptation

**controlpanel** (has async tests with SQLFile decorator):
```python
# Claude learns from conftest.py and existing tests
@SQLFile("data.sql")
async def test_my_endpoint(async_client: AsyncClient):
    resp = await async_client.get("/endpoint")
    assert resp.status_code == 200
```

**data_import_sqs** (has sync tests with moto):
```python
# Claude learns from test_lambda_function.py
@pytest.fixture
def mock_boto3():
    with mock_aws():
        yield boto3.client('s3')

def test_lambda_handler(mock_boto3):
    result = lambda_handler(event, context)
    assert result['statusCode'] == 200
```

## Usage

`/generate-tests <file_path>`

Claude will:
1. Read this template
2. Analyze project's existing tests
3. Build project-specific skill
4. Generate test matching project's style