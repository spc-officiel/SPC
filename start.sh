#!/bin/bash
set -e

ROOT="/home/runner/workspace"

echo ""
echo "══════════════════════════════════════════════"
echo "  SPC SARL — Plateforme Sprint 1"
echo "══════════════════════════════════════════════"

# Install backend dependencies if needed
if [ ! -d "$ROOT/backend/node_modules" ]; then
  echo "📦 Installation dépendances backend..."
  cd "$ROOT/backend" && npm install --silent
fi

# Install site dependencies if needed
if [ ! -d "$ROOT/site/node_modules" ]; then
  echo "📦 Installation dépendances site..."
  cd "$ROOT/site" && npm install --silent
fi

# Create uploads directory
mkdir -p "$ROOT/backend/uploads"

# Start backend API on port 3000
echo "🚀 Backend API → port 3000"
cd "$ROOT/backend" && node server.js &
BACKEND_PID=$!

# Wait for backend
sleep 3

# Start frontend on port 5000
echo "🌐 Frontend site → port 5000"
cd "$ROOT/site" && npm run dev

# Cleanup
kill $BACKEND_PID 2>/dev/null
