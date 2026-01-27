# GitHub Copilot Agent Mode & Coding Agent Workshop Guide

This document provides a comprehensive list of prompts and tasks you can demonstrate during a workshop to showcase GitHub Copilot's Agent Mode and Coding Agent capabilities.

---

## Table of Contents

1. [Codebase Exploration & Understanding](#1-codebase-exploration--understanding)
2. [Code Generation & Development](#2-code-generation--development)
3. [Refactoring & Code Quality](#3-refactoring--code-quality)
4. [Testing](#4-testing)
5. [Debugging & Troubleshooting](#5-debugging--troubleshooting)
6. [Database & Migrations](#6-database--migrations)
7. [API Development](#7-api-development)
8. [Frontend Development](#8-frontend-development)
9. [DevOps & Infrastructure](#9-devops--infrastructure)
10. [Documentation](#10-documentation)
11. [Git & Version Control](#11-git--version-control)
12. [Security](#12-security)
13. [Performance Optimization](#13-performance-optimization)
14. [Multi-Step Complex Tasks](#14-multi-step-complex-tasks)

---

## 1. Codebase Exploration & Understanding

### Architecture Analysis
```
"Explain the architecture of this project"
"What is the folder structure and purpose of each directory?"
"How is the backend connected to the database?"
"Show me the data flow from frontend to database"
```

### Finding Code
```
"Where is user authentication implemented?"
"Find all API routes in this project"
"Show me where error handling is configured"
"Which files handle database connections?"
```

### Understanding Code
```
"Explain what this function does: [paste code or file path]"
"What design patterns are used in this codebase?"
"How does the rate limiting middleware work?"
"Explain the Prisma schema and relationships"
```

---

## 2. Code Generation & Development

### Create New Features
```
"Create a new endpoint to get user statistics"
"Add a notification system for todo deadlines"
"Implement a search feature for todos with filters"
"Create a dashboard component showing project metrics"
```

### Generate Boilerplate
```
"Create a new Express router for notifications"
"Generate a React component for user profile"
"Create a new Prisma model for audit logs"
"Generate TypeScript interfaces for the API responses"
```

### Implement Business Logic
```
"Add logic to automatically archive completed todos after 30 days"
"Implement a priority queue for todos"
"Create a function to calculate project completion percentage"
"Add email validation before creating a user"
```

---

## 3. Refactoring & Code Quality

### Code Improvements
```
"Refactor this function to use async/await instead of callbacks"
"Extract this logic into a reusable utility function"
"Apply the DRY principle to these similar functions"
"Convert this class component to a functional component with hooks"
```

### Code Organization
```
"Move all database queries to a separate repository layer"
"Create a service layer for business logic"
"Organize imports following best practices"
"Split this large file into smaller modules"
```

### Type Safety
```
"Add TypeScript types to this JavaScript file"
"Create proper interfaces for all API responses"
"Fix all TypeScript errors in this file"
"Add Zod validation schemas for all endpoints"
```

---

## 4. Testing

### Unit Tests
```
"Write unit tests for the todo service"
"Create tests for the user validation functions"
"Generate test cases for edge cases in the priority calculation"
"Add tests for the error handling middleware"
```

### Integration Tests
```
"Write integration tests for the user API endpoints"
"Create E2E tests for the todo creation flow"
"Generate API tests using supertest"
"Write tests for database operations"
```

### Test Improvements
```
"Increase test coverage for the project routes"
"Add mock implementations for external services"
"Fix the failing tests and explain why they failed"
"Generate test data factories for todos and users"
```

---

## 5. Debugging & Troubleshooting

### Error Analysis
```
"Why is this test failing?"
"Debug this error: [paste error message]"
"Find the cause of this memory leak"
"Why is the API returning 500 on this endpoint?"
```

### Performance Issues
```
"Why is this query slow?"
"Find N+1 query problems in the codebase"
"Identify bottlenecks in the API"
"Analyze why the frontend is rendering slowly"
```

### Fix Issues
```
"Fix the CORS error when calling the API"
"Resolve the TypeScript compilation errors"
"Fix the race condition in this async function"
"Debug why the Redis connection is failing"
```

---

## 6. Database & Migrations

### Schema Changes
```
"Add a 'priority' field to the Todo model"
"Create a new table for notifications"
"Add an index on the email field for faster lookups"
"Create a many-to-many relationship between users and projects"
```

### Migrations
```
"Generate a Prisma migration for the schema changes"
"Create a migration to add soft delete to all tables"
"Write a data migration to populate the new field"
"Rollback the last migration and explain the process"
```

### Database Operations
```
"Create seed data for testing"
"Write a query to find all overdue todos"
"Optimize this complex database query"
"Add database connection pooling configuration"
```

---

## 7. API Development

### REST Endpoints
```
"Create CRUD endpoints for notifications"
"Add pagination to the GET /todos endpoint"
"Implement sorting and filtering for the projects API"
"Add rate limiting to sensitive endpoints"
```

### API Features
```
"Add request validation using Zod"
"Implement API versioning"
"Add response caching with Redis"
"Create an API health check endpoint with detailed status"
```

### Documentation
```
"Generate OpenAPI/Swagger documentation for all endpoints"
"Add JSDoc comments to all route handlers"
"Create a Postman collection for the API"
"Document all error codes and responses"
```

---

## 8. Frontend Development

### Components
```
"Create a modal component for editing todos"
"Build a data table with sorting and filtering"
"Implement a notification toast system"
"Create a loading skeleton for the dashboard"
```

### State Management
```
"Add React Query for server state management"
"Implement optimistic updates for todo completion"
"Create a global error boundary component"
"Add local storage persistence for user preferences"
```

### UI/UX
```
"Add dark mode support to the application"
"Implement responsive design for mobile devices"
"Add keyboard shortcuts for common actions"
"Create smooth animations for list transitions"
```

---

## 9. DevOps & Infrastructure

### Local Development
```
"Run the application locally"
"Set up the development environment from scratch"
"Fix Docker Compose configuration issues"
"Create a script to reset the development database"
```

### CI/CD
```
"Create a GitHub Actions workflow for CI"
"Add automated testing to the pipeline"
"Set up deployment to Azure App Service"
"Configure environment-specific builds"
```

### Infrastructure
```
"Create Terraform configuration for Azure resources"
"Add Application Insights instrumentation"
"Configure Redis caching for production"
"Set up database backups and recovery"
```

### Monitoring
```
"Add structured logging throughout the application"
"Create custom metrics for business KPIs"
"Set up alerts for error rate thresholds"
"Implement distributed tracing"
```

---

## 10. Documentation

### Code Documentation
```
"Add comprehensive README for the project"
"Document all environment variables"
"Create API documentation with examples"
"Write inline comments for complex logic"
```

### Architecture Docs
```
"Create an architecture diagram description"
"Document the deployment process"
"Write a troubleshooting guide"
"Create onboarding documentation for new developers"
```

---

## 11. Git & Version Control

### Branch Management
```
"Create a feature branch for the new notification system"
"Show me the diff between main and this branch"
"List all recent commits with their descriptions"
"Find which commit introduced this bug"
```

### Commits & PRs
```
"Generate a commit message for these changes"
"Create a pull request description"
"Review the changes in the last commit"
"Squash the last 3 commits into one"
```

---

## 12. Security

### Vulnerability Analysis
```
"Check for SQL injection vulnerabilities"
"Find any exposed secrets in the codebase"
"Audit the dependencies for security issues"
"Review authentication implementation for weaknesses"
```

### Security Improvements
```
"Add input sanitization to all endpoints"
"Implement CSRF protection"
"Add security headers to the API"
"Create a rate limiter for login attempts"
```

---

## 13. Performance Optimization

### Backend Performance
```
"Optimize database queries for the dashboard"
"Add caching to frequently accessed data"
"Implement connection pooling"
"Profile and optimize slow endpoints"
```

### Frontend Performance
```
"Add code splitting for better load times"
"Implement lazy loading for images"
"Optimize React re-renders"
"Add service worker for offline support"
```

---

## 14. Multi-Step Complex Tasks

### Feature Implementation (End-to-End)
```
"Implement a complete notification feature:
1. Create the database model
2. Add API endpoints
3. Create the frontend components
4. Write tests
5. Update documentation"
```

### Refactoring Projects
```
"Refactor the todo module:
1. Extract business logic to services
2. Add proper error handling
3. Implement validation
4. Add unit tests
5. Update API documentation"
```

### Migration Tasks
```
"Migrate from JavaScript to TypeScript:
1. Identify files to migrate
2. Add TypeScript configuration
3. Convert files one by one
4. Fix type errors
5. Update build process"
```

---

## Workshop Demo Script

### Quick Wins (5 minutes each)
1. "Explain the architecture of this project" - Shows exploration
2. "Add a 'dueDate' field to the Todo model and create migration" - Shows DB work
3. "Create unit tests for the todo service" - Shows testing
4. "Fix all TypeScript errors in this project" - Shows debugging

### Medium Tasks (10-15 minutes)
1. "Create a complete notification system with API and frontend"
2. "Add comprehensive API documentation with Swagger"
3. "Set up GitHub Actions CI/CD pipeline"

### Advanced Demo (20-30 minutes)
1. "Implement a complete audit logging system:
   - Track all CRUD operations
   - Store in database
   - Create API to query logs
   - Add frontend dashboard
   - Write tests"

---

## Tips for Workshop Presenters

### Before the Workshop
- Ensure all dependencies are installed
- Have Docker running for database services
- Pre-configure environment variables
- Test all demo scenarios

### During the Workshop
- Start with simple exploration tasks to build confidence
- Show the agent's reasoning and tool usage
- Demonstrate error recovery and iteration
- Highlight the multi-file editing capabilities

### Best Practices to Emphasize
- Be specific in your prompts
- Provide context when needed
- Let the agent complete before interrupting
- Review generated code before committing
- Use for learning, not blind copy-paste

---

## Common Prompt Patterns

### The Specific Request
```
"Create a function called calculateProjectProgress that takes a projectId 
and returns the percentage of completed todos"
```

### The Exploration + Action
```
"Find where user validation is implemented and add email format validation"
```

### The Fix Request
```
"The /api/todos endpoint returns 500 when the database is empty. Fix this."
```

### The Multi-Step Task
```
"1. Add a 'tags' field to todos
 2. Create the API endpoints for managing tags
 3. Update the frontend to display and edit tags
 4. Write tests for the new functionality"
```

### The Learning Request
```
"Explain how the rate limiting middleware works and suggest improvements"
```

---

## Troubleshooting Common Issues

| Issue | Solution |
|-------|----------|
| Agent stops mid-task | Prompt: "Continue with the previous task" |
| Wrong file edited | Prompt: "Undo that change and edit [correct file] instead" |
| Missing context | Prompt: "Read [file] first, then make the changes" |
| Too many changes | Prompt: "Make only the minimal changes needed for X" |
| Unclear output | Prompt: "Explain what you changed and why" |

---

## Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [VS Code Copilot Extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [Copilot Chat Documentation](https://docs.github.com/en/copilot/github-copilot-chat)

---

*Last updated: January 2026*
