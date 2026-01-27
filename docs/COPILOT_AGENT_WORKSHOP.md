# GitHub Copilot Agent Mode & Coding Agent Workshop Guide

This document provides **validated prompts** based on the actual SRE Demo project implementation. All tasks are mapped to existing code, APIs, and infrastructure components.

---

## Table of Contents

1. [Project Overview - What's Already Implemented](#1-project-overview---whats-already-implemented)
2. [Codebase Exploration](#2-codebase-exploration)
3. [Debugging Intentional Bugs (Chaos Engineering)](#3-debugging-intentional-bugs-chaos-engineering)
4. [Database & Schema Operations](#4-database--schema-operations)
5. [API Development & Enhancement](#5-api-development--enhancement)
6. [Frontend Development](#6-frontend-development)
7. [Testing & Quality](#7-testing--quality)
8. [DevOps & CI/CD](#8-devops--cicd)
9. [Azure Infrastructure](#9-azure-infrastructure)
10. [GitHub Platform Integration](#10-github-platform-integration)
11. [Multi-Step Complex Tasks](#11-multi-step-complex-tasks)
12. [Workshop Demo Scripts](#12-workshop-demo-scripts)

---

## 1. Project Overview - What's Already Implemented

### Existing Models (Prisma Schema)
| Model | Fields | Relationships |
|-------|--------|---------------|
| `Todo` | id, title, description, completed, priority, dueDate | tags, metadata, assignee, project, comments, attachments |
| `User` | id, email, name, avatar, role | todos, comments, projects |
| `Project` | id, name, description, color, icon, status | todos, members |
| `Tag` | id, name, color | todos (many-to-many) |
| `Comment` | id, content, todoId, authorId | todo, author |
| `Attachment` | id, filename, fileUrl, fileSize, mimeType | todo |
| `TodoMetadata` | id, viewCount, lastViewedAt, estimatedTime | todo |

### Existing API Routes
| Route | Methods | Description |
|-------|---------|-------------|
| `/api/todos` | GET, POST | List/create todos |
| `/api/todos/:id` | GET, PUT, DELETE | CRUD single todo |
| `/api/todos/:id/toggle` | POST | Toggle completion |
| `/api/todos/search` | GET | Search todos |
| `/api/users` | GET, POST | User management |
| `/api/projects` | GET, POST | Project management |
| `/api/chaos/*` | POST | Chaos engineering endpoints |
| `/api/health` | GET | Health check |

### Existing Frontend Pages
- `Dashboard.tsx` - Main dashboard with metrics
- `TodosPage.tsx` - Todo list management
- `ProjectsPage.tsx` / `ProjectDetails.tsx` - Project views
- `UsersPage.tsx` / `UserDetails.tsx` - User management

### Existing Infrastructure
- GitHub Workflows: `backend-deploy.yml`, `frontend-deploy.yml`, `infrastructure-deploy.yml`
- Terraform configs in `/terraform/` for Azure deployment
- Docker Compose for local development (PostgreSQL + Redis)
- GitHub Copilot Agent: `.github/agents/azure.agent`

### Intentional Bugs for Demo
| Scenario | Trigger | Location |
|----------|---------|----------|
| N+1 Query | `GET /api/todos?inefficient=true` | todoRoutes.ts |
| Cache Invalidation Bug | `PUT /api/todos/:id?skipCache=true` | todoRoutes.ts |
| Missing DB Index | `GET /api/todos/search?q=...` | schema.prisma (commented) |
| Memory Leak | `POST /api/chaos/memory-leak/trigger` | chaosRoutes.ts |
| CPU Spike | `POST /api/chaos/cpu-spike` | chaosRoutes.ts |
| Pool Exhaustion | `POST /api/chaos/exhaust-pool` | chaosRoutes.ts |
| Unhandled Promise | `POST /api/chaos/unhandled-promise` | chaosRoutes.ts |
| DB Timeout | `POST /api/chaos/db-timeout` | chaosRoutes.ts |

---

## 2. Codebase Exploration

### Understanding the Architecture
```
"Explain the architecture of this SRE Demo project"

"What is the relationship between Todo, User, and Project models in the Prisma schema?"

"How does the caching layer work with Redis in this application?"

"Explain the middleware chain in the Express backend (helmet, cors, rateLimiter, etc.)"

"How is Application Insights integrated for monitoring?"
```

### Finding Specific Code
```
"Find all the intentional bugs in this codebase for chaos engineering demos"

"Where is the N+1 query problem implemented and how do I trigger it?"

"Show me how the rate limiting middleware is configured"

"Find all Zod validation schemas used in the API routes"

"How is graceful shutdown implemented in the Express server?"
```

### Code Review
```
"Review the todoRoutes.ts file for potential improvements"

"What security measures are already implemented in this backend?"

"Analyze the error handling strategy in middleware/errorHandler.ts"

"Review the Prisma schema for missing indexes that could impact performance"
```

---

## 3. Debugging Intentional Bugs (Chaos Engineering)

### Diagnose and Fix N+1 Query Problem
```
"The GET /api/todos endpoint is slow when inefficient=true is passed. 
Analyze the N+1 query problem in todoRoutes.ts and show me the fix."

"Compare the performance difference between the efficient and inefficient 
query patterns in the todos endpoint"

"Find all N+1 query patterns in the codebase and suggest optimizations"
```

### Fix Cache Invalidation Bug
```
"There's a cache invalidation bug in the PUT /api/todos/:id endpoint 
when skipCache=true is passed. Explain the issue and implement the fix."

"How should cache invalidation be properly handled in this application?"

"Add proper cache invalidation strategy for all CRUD operations on todos"
```

### Fix Missing Database Indexes
```
"The /api/todos/search endpoint is doing a full table scan. 
Add the missing indexes to the Prisma schema and create a migration."

"Review the Prisma schema and add appropriate indexes for common queries"

"Explain why the search endpoint is slow and implement database-level optimization"
```

### Analyze Memory Leak
```
"Analyze the memory leak implementation in chaosRoutes.ts and explain:
1. Why it causes memory to grow
2. How to detect it in production
3. How to fix it"

"What Application Insights queries would help detect this memory leak in production?"
```

### Fix Error Handling
```
"The POST /api/todos endpoint may expose sensitive information on error.
Review and implement proper error handling without information leakage."

"Add proper error sanitization to prevent stack traces from reaching clients"
```

---

## 4. Database & Schema Operations

### Add New Fields
```
"Add a 'status' enum field (DRAFT, ACTIVE, ARCHIVED) to the Todo model 
and create the migration"

"Add a 'deadline' field with automatic overdue calculation to the Project model"

"Add audit fields (createdBy, updatedBy) to all models"
```

### Create New Models
```
"Create a Notification model with:
- id, type (enum), message, read status
- relation to User
- timestamps
Then generate the migration"

"Create an AuditLog model to track all CRUD operations on todos"

"Create a Label model similar to Tag but with icon support"
```

### Schema Improvements
```
"Add soft delete (deletedAt field) to Todo and Project models"

"Implement the missing indexes as suggested in the schema comments:
@@index([title])
@@index([completed])
@@index([createdAt])"

"Add cascade delete rules for all dependent relationships"
```

### Data Operations
```
"Create a seed script that generates 100 realistic todos with random assignments"

"Write a data migration script to populate the TodoMetadata for existing todos"

"Create a script to archive completed todos older than 30 days"
```

---

## 5. API Development & Enhancement

### Enhance Existing Endpoints
```
"Add pagination to GET /api/todos with limit, offset, and total count"

"Add sorting options (by createdAt, dueDate, priority) to GET /api/todos"

"Implement filtering by multiple fields (status, assignee, project, tags) for todos"

"Add a GET /api/todos/overdue endpoint that returns todos past their dueDate"
```

### Create New Endpoints
```
"Create GET /api/stats endpoint returning:
- Total todos by status
- Todos per user
- Todos per project
- Average completion time"

"Create POST /api/todos/bulk for creating multiple todos at once"

"Create GET /api/users/:id/activity showing recent actions by the user"

"Create endpoints for Comment CRUD operations on todos"
```

### API Features
```
"Add request body validation using Zod for all POST/PUT endpoints in userRoutes.ts"

"Implement API rate limiting per user based on their role"

"Add ETag support for caching in the GET /api/todos/:id endpoint"

"Create an OpenAPI/Swagger specification for all endpoints"
```

### Error Handling
```
"Improve error handling in projectRoutes.ts to match the pattern in todoRoutes.ts"

"Add proper 404 handling when a related resource (user, project) doesn't exist"

"Create custom error types for business logic errors (e.g., CannotDeleteProjectWithTodos)"
```

---

## 6. Frontend Development

### Enhance Existing Pages
```
"Add a search bar with debouncing to the TodosPage component"

"Implement drag-and-drop reordering for todos in TodosPage"

"Add a Kanban board view option to the Dashboard showing todos by status"

"Create a calendar view component showing todos by due date"
```

### Create New Components
```
"Create an EditTodoModal component reusing the CreateTodoModal pattern"

"Build a UserAvatar component that displays user initials if no avatar is set"

"Create a ProgressBar component showing project completion percentage"

"Build a NotificationBell component that shows unread notification count"
```

### State Management
```
"Implement optimistic updates for todo completion toggle using React Query"

"Add offline support that queues mutations when the user is offline"

"Create a global notification system using React Context"

"Add keyboard shortcuts: Ctrl+N for new todo, Ctrl+/ for search"
```

### UI/UX Improvements
```
"Add loading skeletons to Dashboard.tsx while data is fetching"

"Implement infinite scroll for the todos list instead of pagination"

"Add toast notifications for all CRUD operations using react-hot-toast"

"Add dark mode toggle with persistence in localStorage"
```

---

## 7. Testing & Quality

### Unit Tests
```
"Write unit tests for the Zod validation schemas in todoRoutes.ts"

"Create tests for the cache utility functions in config/redis.ts"

"Write tests for the error handling middleware"

"Test the trackEvent and trackMetric functions from appInsights.ts"
```

### Integration Tests
```
"Write integration tests for the complete todo CRUD flow using supertest"

"Create tests that verify the N+1 query fix works correctly"

"Test the rate limiting middleware with concurrent requests"

"Write tests for the chaos endpoints verifying they trigger expected behaviors"
```

### Test Infrastructure
```
"Set up Jest configuration with proper TypeScript support"

"Create a test database setup script using Docker"

"Add test utilities for mocking Prisma and Redis"

"Create test factories for generating realistic Todo, User, Project data"
```

### Code Quality
```
"Fix all ESLint errors in the backend/src directory"

"Add missing TypeScript types to any 'any' usage in the codebase"

"Configure Prettier and format all files consistently"

"Add pre-commit hooks using Husky for lint and type checking"
```

---

## 8. DevOps & CI/CD

### Local Development
```
"Run the complete application locally with Docker Compose"

"Create a script that resets the local database and runs fresh seeds"

"Add a health check script that verifies all services are running"

"Configure hot-reload for both backend and frontend simultaneously"
```

### GitHub Actions Workflows
```
"Add a PR check workflow that runs tests and linting on pull requests"

"Create a workflow that builds and validates Terraform changes"

"Add security scanning (npm audit, Snyk) to the CI pipeline"

"Create a workflow that generates and publishes API documentation"
```

### Enhance Existing Workflows
```
"Add Slack/Teams notification to backend-deploy.yml on deployment success/failure"

"Implement blue-green deployment strategy in the workflows"

"Add manual approval gates for production deployments"

"Create a rollback workflow that can revert to previous deployment"
```

### Docker & Containers
```
"Optimize the backend Dockerfile for smaller image size using multi-stage builds"

"Create a Docker Compose override for running the full stack locally"

"Add health checks to the Docker containers"

"Create a docker-compose.test.yml for running integration tests"
```

---

## 9. Azure Infrastructure

### Using the Azure Agent (@azure)
```
"@azure Explain the current Terraform configuration in /terraform/"

"@azure Add an Azure Alert Rule for API response time > 2 seconds"

"@azure How do I scale the App Service plan if traffic increases?"

"@azure Troubleshoot why Application Insights is not receiving telemetry"
```

### Terraform Enhancements
```
"Add Azure Key Vault to the Terraform configuration for secret management"

"Create a staging environment configuration using Terraform workspaces"

"Add Application Insights availability tests in Terraform"

"Configure auto-scaling rules for the App Service based on CPU usage"
```

### Monitoring & Alerting
```
"Create Application Insights alerts for:
- HTTP 5xx error rate > 5%
- Response time p99 > 3 seconds
- Memory usage > 80%"

"Add custom metrics to track business KPIs (todos created per hour, etc.)"

"Create a Log Analytics query to find slow database queries"

"Set up Azure Monitor dashboard for the SRE Demo application"
```

### Security & Compliance
```
"Enable Azure Managed Identity for the App Service to access Key Vault and Redis"

"Configure private endpoints for PostgreSQL and Redis"

"Add Azure Front Door with WAF rules for the frontend"

"Enable Azure Defender for the subscription resources"
```

---

## 10. GitHub Platform Integration

### GitHub Copilot Agents
```
"@azure Deploy the backend to Azure App Service"

"@azure Check the health of all Azure resources"

"Create a new GitHub Copilot agent for database operations"

"Extend the azure.agent to include cost optimization recommendations"
```

### GitHub Actions
```
"Create a GitHub Action that comments on PRs with test coverage changes"

"Add a workflow that automatically creates issues for failed deployments"

"Create a scheduled workflow that runs chaos tests daily"

"Implement branch protection rules via GitHub API"
```

### Repository Management
```
"Create CODEOWNERS file assigning reviewers by file path"

"Set up issue templates for bugs, features, and performance issues"

"Create a PR template with checklist for code reviews"

"Add dependabot.yml for automated dependency updates"
```

---

## 11. Multi-Step Complex Tasks

### Implement Notifications Feature (End-to-End)
```
"Implement a complete notification system:
1. Create Notification model in Prisma with types (TODO_ASSIGNED, COMMENT_ADDED, DUE_DATE_REMINDER)
2. Create notificationRoutes.ts with GET /api/notifications and PATCH /api/notifications/:id/read
3. Create NotificationList and NotificationItem components
4. Add NotificationBell to the Layout with unread count
5. Write integration tests for the notification endpoints
6. Update the seed script to include sample notifications"
```

### Implement Activity Feed
```
"Create an activity feed feature:
1. Create ActivityLog model tracking all entity changes
2. Add middleware to automatically log CRUD operations
3. Create GET /api/activity endpoint with filtering by entity type and user
4. Build ActivityFeed component for the dashboard
5. Add real-time updates using polling or SSE"
```

### Fix All Performance Issues
```
"Optimize the application performance:
1. Fix the N+1 query in GET /api/todos
2. Add the missing database indexes
3. Implement proper caching strategy with cache invalidation
4. Add connection pooling for PostgreSQL
5. Profile and optimize the slowest endpoints
6. Add performance monitoring dashboards"
```

### Implement Complete CI/CD Pipeline
```
"Set up production-ready CI/CD:
1. Create workflow for automated testing on PR
2. Add security scanning with npm audit and CodeQL
3. Create staging deployment with approval gates
4. Implement automated rollback on health check failure
5. Add deployment notifications to Slack/Teams
6. Create dashboards tracking deployment frequency and failure rate"
```

### Security Hardening
```
"Implement security best practices:
1. Audit all endpoints for input validation
2. Add CSRF protection
3. Implement proper secrets management with Azure Key Vault
4. Add security headers (already using Helmet, but verify configuration)
5. Create security scanning in CI pipeline
6. Document security practices in README"
```

---

## 12. Workshop Demo Scripts

### 5-Minute Quick Demos

#### Demo 1: Explore and Explain
```
"Explain the complete architecture of this SRE Demo project, including:
- How the backend is structured
- What databases are used
- How caching works
- What monitoring is in place"
```

#### Demo 2: Find and Fix Bug
```
"Find the N+1 query problem in this codebase, explain why it's a problem, 
and implement the fix"
```

#### Demo 3: Add Feature
```
"Add a GET /api/todos/stats endpoint that returns count of todos by priority level"
```

#### Demo 4: Run Locally
```
"Run this application locally using Docker Compose"
```

### 15-Minute Medium Demos

#### Demo 1: Database Evolution
```
"Add a 'labels' feature to todos:
1. Create a Label model with name, color, and icon
2. Add many-to-many relationship with Todo
3. Generate migration
4. Add API endpoint to manage labels
5. Update seed data"
```

#### Demo 2: Frontend Enhancement
```
"Add filtering to the TodosPage:
1. Add filter dropdowns for status, priority, and project
2. Update the API call to include filter parameters
3. Persist filter state in URL params
4. Add clear filters button"
```

#### Demo 3: Debugging Session
```
"Debug and fix all the intentional bugs in this application:
1. N+1 query problem
2. Cache invalidation bug
3. Missing database indexes
Then verify each fix works correctly"
```

### 30-Minute Advanced Demos

#### Demo 1: Full Feature Implementation
```
"Implement a complete commenting system for todos:
1. The Comment model already exists, create full CRUD endpoints
2. Update Todo GET to include comments
3. Create CommentSection component for TodoDetails
4. Add real-time comment count in todo list
5. Write tests for comment operations
6. Update API documentation"
```

#### Demo 2: DevOps Complete Setup
```
"Create a complete CI/CD pipeline:
1. Add PR checks workflow (test, lint, build)
2. Add security scanning
3. Create staging environment deployment
4. Add production deployment with approval
5. Configure notifications
6. Create monitoring dashboard"
```

---

## Tips for Workshop Presenters

### Preparation Checklist
- [ ] Docker Desktop running
- [ ] `docker-compose up -d` completed
- [ ] Backend `.env` file configured
- [ ] `npm install` in both backend and frontend
- [ ] Database migrated and seeded
- [ ] Both servers running (backend:3000, frontend:5173)
- [ ] Azure subscription available (for Azure demos)
- [ ] GitHub repository with Actions enabled

### Progressive Difficulty
1. **Start simple**: Codebase exploration ("Explain this project")
2. **Show finding**: "Find the N+1 query bug"
3. **Demo fixing**: "Fix the N+1 query problem"
4. **Add features**: "Add pagination to todos API"
5. **Complex tasks**: "Implement notification feature end-to-end"

### Key Points to Highlight
- Agent reads files automatically to understand context
- Can execute terminal commands (npm, docker, git)
- Edits multiple files in coordinated changes
- Understands relationships between code components
- Can run and validate changes

### Error Recovery Phrases
```
"Continue from where you stopped"
"That's not quite right, the issue is in [file]. Try again."
"Undo the last change and instead..."
"Show me what you changed before applying"
```

---

## Troubleshooting Guide

| Issue | Prompt Solution |
|-------|-----------------|
| Agent editing wrong file | "Stop. You should edit [correct file], not [wrong file]" |
| Change too invasive | "Make minimal changes only to fix X, don't refactor other code" |
| Missing context | "First read [file1] and [file2], then make the changes" |
| Unclear about existing code | "Explain what [function/file] currently does before changing it" |
| Command failed | "The command failed with: [error]. How do I fix this?" |
| Test failing | "Run the tests and fix any failures" |
| TypeScript errors | "Fix all TypeScript errors in the project" |

---

## Quick Reference: API Endpoints

### Chaos Engineering (for demos)
```bash
# Enable memory leak
curl -X POST http://localhost:3000/api/chaos/memory-leak/enable

# Trigger memory leak
curl -X POST http://localhost:3000/api/chaos/memory-leak/trigger

# Disable and cleanup
curl -X POST http://localhost:3000/api/chaos/memory-leak/disable

# Trigger CPU spike (30 seconds)
curl -X POST http://localhost:3000/api/chaos/cpu-spike?duration=30000

# Get chaos status
curl http://localhost:3000/api/chaos/status

# Reset all chaos
curl -X POST http://localhost:3000/api/chaos/reset
```

### Normal Operations
```bash
# Get todos (efficient)
curl http://localhost:3000/api/todos

# Get todos (N+1 bug)
curl "http://localhost:3000/api/todos?inefficient=true"

# Search todos (slow - missing index)
curl "http://localhost:3000/api/todos/search?q=test"

# Update with cache bug
curl -X PUT http://localhost:3000/api/todos/[id]?skipCache=true \
  -H "Content-Type: application/json" \
  -d '{"title": "Updated"}'

# Health check
curl http://localhost:3000/api/health
```

---

## Resources

- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [VS Code Copilot Chat](https://code.visualstudio.com/docs/copilot/copilot-chat)
- [Project Docs: Architecture](./ARCHITECTURE.md)
- [Project Docs: Chaos Scenarios](./CHAOS_SCENARIOS.md)
- [Project Docs: Deployment](./DEPLOYMENT.md)

---

*Document validated against sre-demo codebase - January 2026*
