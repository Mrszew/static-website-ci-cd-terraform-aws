# Git Flow Workflow

## Overview
This project follows the Git Flow branching strategy for managing feature development, releases, and hotfixes.

## Branch Structure

### Main Branches
- **`main`** - Production-ready code
- **`develop`** - Integration branch for features

### Supporting Branches
- **`feature/*`** - Feature development branches
- **`release/*`** - Release preparation branches
- **`hotfix/*`** - Critical production fixes

## Workflow

### 1. Feature Development
```bash
# Create feature branch from develop
git checkout develop
git pull origin develop
git checkout -b feature/new-feature

# Make changes and commit
git add .
git commit -m "feat: add new feature"

# Push feature branch
git push origin feature/new-feature

# Create Pull Request to develop
# After review and approval, merge to develop
```

### 2. Development Integration
```bash
# All features are merged to develop
# develop branch triggers CI/CD to development environment
# Run acceptance tests on dev environment
```

### 3. Release Preparation
```bash
# Create release branch from develop
git checkout develop
git checkout -b release/v1.0.0

# Make release-specific changes (version bump, etc.)
git commit -m "chore: bump version to 1.0.0"

# Merge to main and develop
git checkout main
git merge release/v1.0.0
git tag v1.0.0
git push origin main --tags

git checkout develop
git merge release/v1.0.0
git push origin develop

# Delete release branch
git branch -d release/v1.0.0
```

### 4. Hotfix Process
```bash
# Create hotfix branch from main
git checkout main
git checkout -b hotfix/critical-fix

# Make critical fix
git commit -m "fix: critical production issue"

# Merge to main and develop
git checkout main
git merge hotfix/critical-fix
git tag v1.0.1
git push origin main --tags

git checkout develop
git merge hotfix/critical-fix
git push origin develop

# Delete hotfix branch
git branch -d hotfix/critical-fix
```

## CI/CD Integration

### Branch Triggers
- **`main`** → Deploy to Production
- **`develop`** → Deploy to Development
- **Pull Requests** → Run tests only

### Environment Flow
1. **Feature Branch** → Tests only
2. **Develop** → Deploy to Development + Acceptance Tests
3. **Main** → Deploy to Production + Smoke Tests

## Current Setup
- ✅ Develop branch created
- ✅ Multi-environment deployment configured
- ✅ Pull request triggers enabled
- ✅ Acceptance tests for development
- ✅ Smoke tests for production 