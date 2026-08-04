---
title: Multi Agent Workspace
created: 2026-06-30
updated: 2026-06-30
type: entity
tags: [uncategorized]
---
# Multi-Agent Workspace Architecture

**Last updated:** 2026-05-17
**Context:** Architectural discussion following LiteLLM native migration and Sentinel health check implementation.

---

## Sentinel — Boot-Time Health Gate

Sentinel (`~/.hermes/ops/sentinel/sentinel.py`) is the workspace's boot-time health orchestrator. It runs as a systemd `Type=oneshot` — a unit that executes to completion and exits, not a daemon. systemd records the exit code (0=healthy, 1=degraded, 2=critical) and other units can depend on it via `After=` and `Requires=`.

**Services monitored:**

| Service | Check | Port | Critical | Stack |
|---------|-------|------|----------|-------|
| PostgreSQL 17 | TCP | 5432 | yes | memory-db |
| LiteLLM | HTTP (auth) | 4000 | yes | inference |
| Langfuse | HTTP | 3001 | no | observability |
| NATS JetStream | TCP | 9193 | no | events |
| FocalBoard | HTTP | 9090 | no | issues |
| Forgejo | HTTP | 3020 | no | git-ci |
| Caddy | TCP | 80 | no | reverse-proxy |

**Safe mode:** If LiteLLM is unhealthy AND Hermes config.yaml uses `provider: custom:litellm`, Sentinel backs up the config and swaps to a safe-mode template that routes directly to provider APIs. If LiteLLM recovers and a backup exists, Sentinel auto-restores.

Sentinel is designed to serve as:
- **Super-container CMD/init** — runs before the main supervisor
- **k8s init container** — probes dependencies before pod starts
- **k8s liveness probe** — periodic health check
- **Systemd oneshot** — boot-time gate (current deployment)

---

## LiteLLM — Native Migration

LiteLLM was migrated from a Podman container wrapper to a native Python deployment (uv venv, systemd user service) to eliminate a race condition where `newuidmap` would fail under systemd user services during rapid restart cycles.

**Before:** `podman run --rm --network host` wrapper → container namespace layer → Prisma migrations on every boot → 75 restart attempts on failure.
**After:** `.venv/bin/litellm --config config.yaml --port 4000` → direct Python process → systemd manages lifecycle → no namespace layer.

This migration freed Sentinel to focus on workspace health rather than container lifecycle.

---

## The 4-Agent Matrix

The super-container hosts four distinct agent types, defined along two axes:

| Axis | Poles |
|------|-------|
| **Autonomy** | Opinionated (has a fixed persona/behavior) vs Full Control (blank slate, configurable per role) |
| **Scope** | Single Actor (one agent, one session) vs Factory (multi-session, multi-task orchestration engine) |

```
                Single Actor                  Factory
                ─────────────                  ───────
Opinionated     Riki (Chief of Staff)         OpenCode (Dev Engine)
                Her, Hermes-based,            Coding agent with strong
                your interface to the         opinions on test discipline,
                workspace. Handles ops,       architecture, and quality.
                memory, HITL config,          Restricted to ~/lab.
                and delegation.

Full Control    Nanobot (Base Agent)          Pi (Custom Harness)
                Unshaped agent,               Dark factory — fully custom
                configured per role.          tooling, no guardrails,
                CRM agent = Nanobot +         batch inference, scheduled
                Honcho for user modeling.     jobs, custom workflows.
```

### Riki (Opinionated Single Actor)
- **Identity:** Chief of Staff, high-agency, she/her
- **Scope:** Operates in `~/.hermes` — system maintenance, memory management, env config, HITL orchestration
- **Constraints:** SOUL.md — verification mandates, HITL gating, security rules (127.0.0.1 only, no 0.0.0.0)
- **Does NOT write code in ~/lab** — delegates all dev work to OpenCode
- **Tool surface:** Hermes tools (terminal, file, web, browser), delegation, cron, memory

### Nanobot (Full Control Single Actor)
- **Identity:** Blank — configured per deployment
- **Scope:** Customer-facing roles (CRM agent = Nanobot + Honcho for persistent user modeling)
- **Constraints:** Defined by the deployment config, not a fixed persona
- **Integration:** Honcho for cross-session user memory, LiteLLM for model routing, Langfuse for observability

### OpenCode (Opinionated Factory)
- **Identity:** Claude Code derivative, dev engine
- **Scope:** Operates in `~/lab` — full software development, architecture, implementation
- **Constraints:** No access to ~/.hermes ops, no env config changes, no production infrastructure
- **Tool surface:** Full filesystem + git + PR workflow within lab scope

### Pi (Full Control Factory)
- **Identity:** Dark factory — custom rolled harnesses
- **Scope:** Anything that doesn't fit the other three — batch inference, scheduled processing, ETL, custom workflows
- **Constraints:** None enforced by the platform. All guardrails are self-imposed per workload.

---

## Why the Super-Container

The container is NOT about isolation (the server is dedicated to agents). It's about **platform standardization**:

1. **One build artifact** — a single Containerfile produces an image with all four agents + workspace services pinned to known versions
2. **Atomic versioning** — tag the whole platform (`paradigm/workspace:v2026-05-17`), not four separate install chains
3. **Local cloud discrete** — deploy one super-container per customer, each with its own Nanobot + Honcho pair
4. **Single env injection** — secrets mounted once, all four agents inherit LiteLLM keys, DB creds, Langfuse tokens
5. **Standardized upgrades** — build new image → test in parallel → swap tag → roll

### The "Unshackling" Tradeoff

Running Hermes native (current state) vs containerized (future state):

| Factor | Native (Current) | Container (Future) |
|--------|------------------|-------------------|
| **Startup** | Instant — process launch | Image pull + init + service boot |
| **Debugging** | Direct strace/pdb/ptrace | `podman exec`, cgroup inspection |
| **Rollback** | Manual — undo pip install | `podman run :previous-tag` |
| **Parallel envs** | Test user or dev tree | Native — side-by-side containers |
| **Single agent** | Simpler, faster | Overkill |
| **Multi-agent** | Manual coordination | Built-in — shared runtime |
| **Resource overhead** | Zero | Image storage + namespace |

**Conclusion:** Native for a single-instance agent host. Container for the multi-agent platform. The threshold is the second agent type — once you run Riki + OpenCode + Nanobot + Pi on the same host, the container's shared runtime overhead pays for itself through reduced coordination cost.

---

## Deployment Futures

### Local Cloud (Preferred)
The super-container deployed to a homelab cluster. Each customer/workload gets one instance with its own Nanobot + Honcho pair. Workspace services (PG, NATS, LiteLLM) are shared cluster infrastructure.

### VPS / Cloud VM
Same super-container, single-tenant VPS. No shared cluster infra — all services run inside the container or as adjacent systemd services.

### k8s
Each agent type becomes a deployment:
- **Riki** — Deployment (1 replica), stateful (memory store)
- **OpenCode** — Job/CronJob, ephemeral per task
- **Nanobot** — StatefulSet (1 per customer), with Honcho sidecar
- **Pi** — DaemonSet (1 per node), persistent worker pool

Sentinel becomes the startup probe + init container for Riki's pod.

---

## Current State (May 2026)

- **LiteLLM:** Native Python, systemd user service, port 4000. Health-checked by Sentinel.
- **Sentinel:** Systemd oneshot. Checks 7 services, swaps config if LiteLLM down.
- **Hermes (Riki):** Native venv (`~/.hermes/hermes-agent`), config at `~/.hermes/config.yaml`
- **OpenCode:** Separate Claude Code derivative (`~/.opencode`), routed via LiteLLM
- **Infrastructure:** PostgreSQL 17 (systemd), Langfuse (Docker), NATS (systemd), Forgejo (Docker), Caddy (systemd)
- **No super-container yet** — scaffolding at `~/.hermes/ops/root-container/` awaiting architecture finalization
