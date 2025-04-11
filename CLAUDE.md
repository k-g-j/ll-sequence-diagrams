# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Projects to Focus On
- `atlas-app/` - A web app frontend (Next.js) and backend (Go) for LayerLens
- `evaluation-avs/` - EigenLayer AVS (Actively Validated Service) implementation in Go

## Build & Run Commands
- Atlas Frontend: `cd atlas-app/apps/frontend && npm run dev` - Next.js development server
- Atlas Backend: `cd atlas-app/apps/backend && go run main.go` - Go backend server
- Atlas Docker: `cd atlas-app/docker && docker compose up -d` - All services with Docker
- AVS Contracts: `cd evaluation-avs && make build-contracts` - Build smart contracts
- AVS Operator: `cd evaluation-avs && make build-operator` - Build operator service
- AVS Run Tests: `cd evaluation-avs && make test` - Run all tests

## Test & Lint Commands
- Atlas Frontend Lint: `cd atlas-app/apps/frontend && npm run lint` (fix: `npm run lint:fix`)
- Atlas Frontend Format: `cd atlas-app/apps/frontend && npm run check-format` (fix: `npm run check-format:fix`)
- Atlas Backend Tests: `cd atlas-app/apps/backend && make test`
- Single Backend Test: `cd apps/backend && go test ./tests/api/v1/... -v -run TestSpecificFeature`
- AVS Single Test: `cd evaluation-avs && go test -v ./tests/integration -run TestOperatorFeatures/TestHappyPathEvaluation`

## Code Style Guidelines
- Go: Use gofumpt for formatting, standard Go imports (stdlib, external, internal)
- TypeScript/React: Follow ESLint/Prettier with Next.js 14+ conventions
- Error Handling: Propagate errors upward with context
- Tests: Use testify/suite structure for Go tests
- Naming: CamelCase for Go, PascalCase for React components, camelCase for variables

## Commit and PR Guidelines
- NEVER include Claude attribution in commit messages or PRs
- Do not include phrases like "Generated with Claude Code" or "Co-Authored-By: Claude"
- Keep commit messages concise and focused on the changes made
- Before committing, check for and remove unnecessary files and folders from the repository
- Use `git status` to verify only intended files are being committed

## IMPORTANT: Never commit CLAUDE.md to GitHub
- This file is for local use only
- If updated locally, update copy in git@github.com:k-g-j/claude-cli-markdowns.git as well