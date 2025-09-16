# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- **Start development server**: `pnpm dev` (uses Turbopack for faster builds)
- **Build for production**: `pnpm build` (creates standalone output when NEXTJS_STANDALONE=true)
- **Start production server**: `pnpm start`
- **Lint code**: `pnpm lint` (uses ESLint)

## Architecture Overview

This is a Next.js 15 application configured for containerized deployment with Portainer. The project uses:

### Tech Stack
- **Next.js 15**: App Router architecture with Turbopack for development
- **React 19**: Latest React version with TypeScript
- **TailwindCSS v4**: For styling with PostCSS integration
- **pnpm**: Package manager
- **Docker**: Multi-stage production-ready container builds

### Key Configuration
- **Standalone mode**: The app is configured to output standalone builds for Docker deployment
- **Turbopack**: Enabled for faster development builds
- **Custom fonts**: Uses Geist and Geist Mono fonts

### Docker Architecture
- Multi-stage Dockerfile with optimized layers:
  - `base`: Node.js 24 Alpine with pnpm
  - `dev-deps`: Development dependencies installation
  - `prod-deps`: Production-only dependencies
  - `builder`: Application build stage
  - `runner`: Final production runtime with security hardening
- Docker Compose setup for local development and deployment

### Project Structure
- `/app`: Next.js App Router pages and layouts
- `/app/layout.tsx`: Root layout with font configuration
- `/app/page.tsx`: Home page component
- `next.config.ts`: Next.js configuration with standalone output option
- `Dockerfile`: Production-ready multi-stage build
- `compose.yml`: Docker Compose configuration

### Deployment Context
This project is part of a Portainer deployment pipeline described in the README.md, involving Ubuntu VPS setup, Docker installation, Portainer configuration, and Traefik reverse proxy setup for production.