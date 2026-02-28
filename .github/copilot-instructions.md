# Todo App — Copilot Instructions

## Project Overview

Full-stack Todo application built with modern web technologies and Azure cloud infrastructure.

### Tech Stack

- **Frontend**: React 18 + TypeScript + Vite + Tailwind CSS + React Query
- **Backend**: Node.js 20 + Express + TypeScript + Prisma ORM + Redis + Winston
- **Infrastructure**: Terraform + Azure (PostgreSQL, Redis, App Service, Static Web App, App Insights)
- **Testing**: Playwright with Page Object Model pattern
- **CI/CD**: GitHub Actions (3 workflows)
- **Chaos Engineering**: 10 intentional scenarios for SRE demos

## Key Conventions

### TypeScript

- Strict mode enabled in all tsconfig.json files
- Never use `any` type — use proper types or `unknown` with type guards
- Use interfaces for object shapes, types for unions/intersections

### Frontend (React)

- React Query (TanStack Query) for all data fetching — no raw fetch/axios in components
- Tailwind CSS for styling — no CSS modules or styled-components
- Functional components with hooks only — no class components
- Component files in `frontend/src/components/`
- API service layer in `frontend/src/services/`

### Backend (Express)

- Prisma ORM for all database operations — never use raw SQL
- Winston for structured logging — never use console.log in production code
- Redis for caching with TTL — cache invalidation on mutations
- Routes in `backend/src/routes/`
- Middleware in `backend/src/middleware/`
- Prisma schema in `backend/prisma/schema.prisma`

### Commits

Use conventional commits: `<type>(<scope>): <description>`
Types: feat, fix, docs, refactor, test, chore, ci, infra
Scopes: frontend, backend, terraform, e2e, agents, ci

## File Structure

```
frontend/src/          # React application source
  components/          # React components
  services/            # API service layer
  hooks/               # Custom React hooks
  types/               # TypeScript type definitions
backend/src/           # Express application source
  routes/              # API route handlers
  middleware/          # Express middleware
  services/            # Business logic
  utils/               # Utility functions
backend/prisma/        # Prisma schema and migrations
terraform/             # Azure IaC (main.tf, variables.tf, outputs.tf)
e2e/                   # Playwright E2E tests
  tests/               # Test specs
  pages/               # Page Object Models
  fixtures/            # Test fixtures
```

## Available Agents

| Agent | Domain |
|-------|--------|
| `@playwright-tester` | E2E test orchestration |
| `@playwright-explorer` | Application exploration via browser |
| `@playwright-planner` | Test plan generation |
| `@playwright-implementer` | Test code implementation |
| `@azure-infrastructure` | Azure resource management |
| `@todo-dev` | Full-stack application development |
| `@todo-deploy` | Deployment orchestration |
| `@todo-sre` | SRE, monitoring, and chaos engineering |

## Security Rules

- Never store secrets, passwords, or API keys in code
- Never use `any` type in TypeScript
- Never use raw SQL — always use Prisma ORM
- Use parameterized queries exclusively (Prisma handles this)
- Use OIDC/Managed Identity for Azure authentication
- All environment-specific values go in tfvars files, not in code
- Enable CORS only for known origins
