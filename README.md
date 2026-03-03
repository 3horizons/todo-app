# Todo App — Three Horizons Golden Path

Full-stack Todo application template for the **Three Horizons Agentic DevOps Platform**, built with React 18 + Node.js + TypeScript + Terraform + Azure.

This repository serves as a **Golden Path template** for Red Hat Developer Hub (RHDH). When selected in the RHDH portal, it scaffolds a complete Todo application with Azure infrastructure, CI/CD pipelines, Codespaces environment, and Copilot custom agents.

## Architecture

```
┌─────────────────┐
│  React Frontend  │
│  (Static Web)    │
└────────┬─────────┘
         │
         ▼
┌─────────────────┐      ┌──────────────┐
│  Express API     │◄────►│  PostgreSQL   │
│  (App Service)   │      │  (Flexible)   │
└────────┬─────────┘      └──────────────┘
         │
         ▼
┌─────────────────┐      ┌──────────────┐
│  Redis Cache     │      │  App Insights │
│                  │      │  + Monitoring  │
└─────────────────┘      └──────────────┘
```

## Tech Stack

| Layer | Technology | Hosting |
|-------|-----------|---------|
| Frontend | React 18 + TypeScript + Vite + Tailwind CSS + React Query | Azure Static Web Apps |
| Backend | Node.js 20 + Express + Prisma ORM + Redis + Winston | Azure App Service |
| Database | PostgreSQL 16 | Azure Database for PostgreSQL Flexible Server |
| Cache | Redis 7 | Azure Cache for Redis |
| IaC | Terraform | AzureRM Provider |
| CI/CD | GitHub Actions | 3 pipelines (frontend, backend, infrastructure) |
| Testing | Playwright | E2E with Page Object Model |
| Monitoring | Application Insights + Log Analytics | Azure Monitor |

## Quick Start

### Option 1: GitHub Codespaces (Recommended)

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/3horizons/todo-app?quickstart=1)

The Codespace will automatically:
- Install all dependencies (frontend, backend, e2e)
- Start PostgreSQL and Redis containers
- Run database migrations
- Configure MCP servers for Copilot agents

Then open two terminals:
```bash
# Terminal 1 — Backend
cd backend && npm run dev

# Terminal 2 — Frontend
cd frontend && npm run dev
```

- Frontend: http://localhost:5173
- Backend: http://localhost:3000

### Option 2: Local Development

```bash
# Clone
git clone https://github.com/3horizons/todo-app.git
cd todo-app

# Install dependencies
cd frontend && npm install && cd ..
cd backend && npm install && cd ..

# Start infrastructure
docker-compose -f docker-compose.dev.yml up -d postgres redis

# Run migrations
cd backend && npx prisma migrate dev && cd ..

# Start backend (terminal 1)
cd backend && npm run dev

# Start frontend (terminal 2)
cd frontend && npm run dev
```

## Copilot Agents

This project includes specialized GitHub Copilot custom agents:

| Agent | Command | Description |
|-------|---------|-------------|
| @todo-dev | `@todo-dev "Add priority field to todos"` | Full-stack app development (React + Express + Prisma) |
| @todo-deploy | `@todo-deploy "Deploy to Azure dev"` | Terraform, GitHub Actions, Azure deployment |
| @playwright-tester | `@playwright-tester "Generate tests for Todos"` | Orchestrates full E2E test pipeline |
| @playwright-explorer | `@playwright-explorer "Explore Dashboard"` | Navigates app via Playwright MCP |
| @playwright-planner | `@playwright-planner "Create test plan"` | Generates phased test plans |
| @playwright-implementer | `@playwright-implementer "Implement Phase 1"` | Writes Page Objects + test specs |
| @azure | `@azure "Check App Service health"` | Azure IaC, monitoring, troubleshooting |

### Agent Pipeline

```
@todo-dev (write feature) → @playwright-tester (test it) → @todo-deploy (ship it)
```

## E2E Testing

```bash
cd e2e && npm install && npx playwright install chromium

# Run all tests
npx playwright test

# Run with UI mode
npx playwright test --ui
```

## Infrastructure Deployment

### 1. Configure Azure Secrets

Add these secrets to **Settings → Secrets and variables → Actions**:

| Secret | Description |
|--------|-------------|
| `ARM_CLIENT_ID` | Azure Service Principal App ID |
| `ARM_CLIENT_SECRET` | Azure Service Principal Secret |
| `ARM_SUBSCRIPTION_ID` | Azure Subscription ID |
| `ARM_TENANT_ID` | Azure Tenant ID |
| `POSTGRES_ADMIN_PASSWORD` | PostgreSQL admin password |
| `ALERT_EMAIL` | Email for monitoring alerts |

### 2. Deploy Infrastructure

```bash
# Via GitHub Actions (recommended)
gh workflow run infrastructure-deploy.yml -f action=apply -f environment=dev

# Or manually
cd terraform
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

### 3. Deploy Application

Push to `main` branch — CI/CD pipelines deploy automatically:
- `backend-deploy.yml` → builds Docker image → deploys to App Service
- `frontend-deploy.yml` → builds Vite → deploys to Static Web App

## Monitoring & Alerts

Configured via Terraform:
- High CPU (>80%) and Memory (>85%) alerts
- HTTP 5xx error rate alerts
- Response time degradation (>2s)
- Email notifications to configured alert email

Dashboards available in Azure Portal → Application Insights.

## Project Structure

```
todo-app/
├── frontend/              # React 18 + Vite + Tailwind CSS
│   └── src/
│       ├── components/    # React components
│       ├── pages/         # Route pages
│       └── api/           # HTTP client (Axios)
├── backend/               # Node.js 20 + Express + Prisma
│   ├── src/
│   │   ├── routes/        # API route handlers
│   │   ├── middleware/    # Express middleware
│   │   └── config/        # App config (DB, Redis, AppInsights)
│   └── prisma/            # Schema + migrations
├── terraform/             # Azure IaC
│   └── environments/      # Per-environment tfvars
├── e2e/                   # Playwright E2E tests
│   ├── pages/             # Page Object Models
│   └── tests/             # Test specs
├── .github/
│   ├── workflows/         # CI/CD pipelines
│   ├── agents/            # Copilot custom agents
│   └── instructions/      # Copilot instructions
├── .devcontainer/         # Codespaces environment
├── .vscode/               # VS Code config + MCP servers
└── docs/                  # Architecture, deployment guides
```

## Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Deployment Guide](docs/DEPLOYMENT.md)
- [GitHub Setup](docs/GITHUB_SETUP.md)
- [Copilot Agent Workshop](docs/COPILOT_AGENT_WORKSHOP.md)
- [E2E Testing Instructions](.github/instructions/e2e-testing.instructions.md)

## RHDH Template

This repository is registered as a Software Template in Red Hat Developer Hub. To use it:

1. Open the RHDH portal
2. Go to **Create** → select **Todo App — Three Horizons Golden Path**
3. Fill in the wizard (app name, environment, Azure region)
4. The scaffolder creates a new repo, provisions Azure infrastructure, and registers in the catalog

## License

MIT License

## Resources

- [GitHub Copilot](https://github.com/features/copilot)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Red Hat Developer Hub](https://developers.redhat.com/rhdh)
- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)

---

**Built with the Three Horizons Golden Path — Agentic DevOps Platform**
