#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# Todo App — Three Horizons | Codespaces Post-Create Setup
# NOTE: This file should be chmod +x (run: chmod +x .devcontainer/post-create.sh)
# ──────────────────────────────────────────────────────────────────────────────

echo "╔══════════════════════════════════════════════════════════╗"
echo "║  🚀 Todo App — Three Horizons                          ║"
echo "║  Setting up your development environment...            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ── Step 1: Install frontend dependencies ────────────────────────────────────
echo "📦 [1/6] Installing frontend dependencies..."
cd frontend && npm install
cd ..

# ── Step 2: Install backend dependencies ─────────────────────────────────────
echo "📦 [2/6] Installing backend dependencies..."
cd backend && npm install
cd ..

# ── Step 3: Install E2E test dependencies ────────────────────────────────────
echo "🎭 [3/6] Installing E2E test dependencies..."
cd e2e && npm install && npx playwright install chromium --with-deps
cd ..

# ── Step 4: Start infrastructure services ────────────────────────────────────
echo "🐳 [4/6] Starting PostgreSQL and Redis..."
docker-compose -f docker-compose.dev.yml up -d postgres redis

# ── Step 5: Wait for PostgreSQL to be ready ──────────────────────────────────
echo "⏳ [5/6] Waiting for PostgreSQL to be ready..."
readonly MAX_RETRIES=30
retry_count=0
until pg_isready -h localhost -p 5432 -U postgres 2>/dev/null; do
  retry_count=$((retry_count + 1))
  if [[ ${retry_count} -ge ${MAX_RETRIES} ]]; then
    echo "❌ PostgreSQL did not become ready after ${MAX_RETRIES} attempts"
    exit 1
  fi
  echo "  Waiting for PostgreSQL... (${retry_count}/${MAX_RETRIES})"
  sleep 2
done
echo "✅ PostgreSQL is ready!"

# ── Step 6: Run database migrations ─────────────────────────────────────────
echo "🗄️  [6/6] Running Prisma migrations..."
cd backend && npx prisma migrate dev --name init
cd ..

# ── Optional: Copy MCP config template ───────────────────────────────────────
if [[ -f ".vscode/mcp.json.template" ]]; then
  echo "📋 Copying MCP server configuration..."
  cp .vscode/mcp.json.template .vscode/mcp.json
fi

# ── Done! ────────────────────────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ✅ Development environment is ready!                   ║"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║                                                        ║"
echo "║  🌐 Frontend (Vite):    http://localhost:5173           ║"
echo "║  🔧 Backend (Express):  http://localhost:3000           ║"
echo "║  🐘 PostgreSQL:         localhost:5432                  ║"
echo "║  🔴 Redis:              localhost:6379                  ║"
echo "║                                                        ║"
echo "║  Available Copilot Agents:                             ║"
echo "║  • @todo-dev         Full-stack development            ║"
echo "║  • @todo-deploy      Deployment orchestration          ║"
echo "║  • @playwright-tester    E2E test execution            ║"
echo "║  • @playwright-explorer  Test exploration              ║"
echo "║  • @playwright-planner   Test planning                 ║"
echo "║  • @playwright-implementer Test implementation         ║"
echo "║  • @azure            Azure infrastructure              ║"
echo "║                                                        ║"
echo "║  Quick Start:                                          ║"
echo "║  Terminal 1: cd frontend && npm run dev                ║"
echo "║  Terminal 2: cd backend && npm run dev                 ║"
echo "║                                                        ║"
echo "╚══════════════════════════════════════════════════════════╝"
