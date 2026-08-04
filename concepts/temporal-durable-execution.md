---
title: Temporal Durable Execution — Architecting the Execution Plane
created: 2026-06-01
updated: 2026-06-01
type: concept
tags: [temporal, durable-execution, workflow-orchestration, saga-pattern, observability, audit-trail, nats, langgraph]
status: live
sources:
  - https://temporal.io/product
  - https://docs.temporal.io/evaluate/development-production-features/observability
  - https://temporal.io/blog/replay-2026-product-announcements
  - https://www.kai-waehner.de/blog/2025/06/05/the-rise-of-the-durable-execution-engine-temporal-restate-in-an-event-driven-architecture-apache-kafka
  - https://hoop.dev/blog/what-nats-temporal-actually-does-and-when-to-use-it
  - file:///home/hbtjm/Documents/TechStack/_workflow_temporal+nats+crumbs.md
  - file:///home/hbtjm/Documents/TechStack/_workflow_beyond_agents.md
  - file:///home/hbtjm/Documents/TechStack/_workflow_langgraph.md
---

# Temporal Durable Execution — Architecting the Execution Plane

## What Temporal Actually Is

Temporal is a **durable execution engine** — not a database, not an AI orchestrator, not a message queue. It guarantees that your code runs to completion even across process crashes, machine failures, or full data-center outages. It achieves this by persistently journaling every step of your workflow (event sourcing) and replaying it on worker restart.

**The mental model:** Temporal is the "operating system for long-running distributed work." It manages:
- **What** to execute (workflow definitions)
- **When** to execute (timers, schedules, signals)
- **How** to retry on failure (exponential backoff, compensation)
- **Where** we left off (event history, replay)

## Core Architecture Pattern

The dominant production pattern for Temporal is a **three-layer separation** of responsibilities:

```
┌─────────────────────────────────────────────────────┐
│                    PostgreSQL                         │
│              (System of Record)                       │
│   Answers: What work exists? Who owns it?              │
│            When is it due?                             │
└────────────────────┬────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────┐
│                    Temporal                          │
│              (Execution Engine)                       │
│   Answers: What is running? What failed?              │
│            What retries? What compensation?           │
└────────────────────┬────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────┐
│                    You r App (UI/Control Plane)       │
│              (Visualization Layer)                    │
│   Kanban, Calendar, Gantt, Timeline, Observability   │
└─────────────────────────────────────────────────────┘
```

**Key insight (corroborated by both community and official sources):** Temporal is NOT a replacement for your application database. Business data lives in PostgreSQL. Workflow execution state lives in Temporal. This is Temporal's own recommendation — confirmed by _workflow_temporal+nats+crumbs and https://temporal.io.

## Temporal vs NATS JetStream

This distinction matters for our architecture. They solve different problems:

| Concern | NATS | Temporal |
|---------|------|----------|
| Primary question | "How do I move messages?" | "How do I reliably execute a process?" |
| Optimized for | 100k+ events/sec, telemetry, IoT streams | Important business processes, long-running workflows |
| Failure handling | Consumer retry + DLQ | Automatic retry + compensation (Saga) |
| State model | At-least-once delivery | Exactly-once execution with full event history |
| Best at | Event backbone, async communication, streaming | Tenant provisioning, release workflows, agent orchestration |

**Can Temporal replace some JetStream usage?** Yes — specifically for multi-step process orchestration that currently requires custom retry logic with DLQs (confirmed by hoop.dev analysis). But Temporal is **terrible** at high-throughput event streams (market data, telemetry, log aggregation). NATS shines there.

**The architecture we should use:**
- **NATS JetStream** handles: Agent events, telemetry, notifications, metrics, async communication
- **Temporal** handles: Release workflows, feature workflows, incident response, agent project orchestration, deployment workflows
- **PostgreSQL + pgvector** handles: Tasks, projects, kanban data, Gantt/calendar data, vector embeddings for RAG

This three-layer split is consistent with both community experience (https://hoop.dev/blog/what-nats-temporal-actually-does-and-when-to-use-it) and the analysis in _workflow_temporal+nats+crumbs.

## Temporal vs LangGraph — Where They Fit

The common mistake is framing this as "Temporal OR LangGraph." The more accurate framing is:

```
Temporal          vs    Airflow, Argo, Cadence    (distributed workflow engines)
LangGraph         vs    CrewAI, OpenAI Agents     (agent reasoning frameworks)
```

**Three architectures, increasing in maturity:**

### 1. LangGraph Only
Agent reasoning loops, graph traversal, cycles. Gets agent state and branching but **not** Temporal's event history, workflow replay, durable timers, or exactly-once guarantees. Where many teams start, but production teams quickly outgrow it.

### 2. Temporal Wraps LangGraph (Dominant Production Pattern)
```
Temporal Workflow
  ├── Project Setup (activity)
  ├── LangGraph Activity: Plan → Code → Review
  ├── Human Approval Step (activity)
  └── Deployment (activity)
```
Temporal owns durability, retries, scheduling, audit history, human approvals, recovery.
LangGraph owns reasoning, routing, tool selection, graph traversal.
**Risk:** "Black box LangGraph" — if LangGraph runs entirely inside one Temporal activity, Temporal can't see internal steps. Mitigation: extract each agent step into its own Temporal activity.

### 3. Pure Temporal (Surprisingly Viable)
```
Temporal Workflow
  ├── ArchitectAgent()
  ├── CoderAgent()
  ├── ReviewAgent()
  └── DeployAgent()
```
No LangGraph, no CrewAI — just workflows and activities. For software-factory systems where 70-80% of the workflow is deterministic business process rather than agent cognition, this is simpler, more observable, and easier to audit.

**Decision framework:** The more your system is "software delivery pipeline," the stronger the case for **Temporal-first** with agents as worker activities. The more it's "autonomous research and planning loops," the stronger the case for **LangGraph inside selected Temporal activities**.

Confirmed by _workflow_langraph and cross-referenced against AgentMarketCap (2026) and AI Workflow Lab (2026) analyses.

## Temporal Is NOT an "AI Orchestrator"

Critical distinction that many discussions miss: Temporal was designed for distributed systems, long-running business processes, and Saga orchestration — years before AI agents existed. **AI agents are just one type of workload.**

Temporal's lineage: Uber's Cadence (2015) → Temporal fork (2019) → Open source. It was built for banking workflows, insurance claims, telecom provisioning, e-commerce order processing, SaaS tenant onboarding. These are the primary use cases today.

Confirmed by _workflow_beyond_agents and Temporal's own product page (https://temporal.io/product).

## Observability & Audit Trail

This is where Temporal delivers immediate value for our goals:

### Built-in Observability (Replay 2026)
- **Metrics**: Detailed performance tracking (Temporal Service + Workflow health)
- **Tracing**: End-to-end traces through Workflow → Activity → Retry → Compensation
- **Logging**: Comprehensive auditing of every state transition
- **Search Attributes**: Custom metadata filters on Workflow Executions
- **Web UI** (deployed at `:8233`): Interactive visualization
- **OpenMetrics** (GA as of Replay 2026): Prometheus-native scraping
- **Worker Status UI** (Preview): Heartbeat-based worker visibility
- **Worker Versioning** (GA): Progressive rollouts without breaking in-flight executions

### Audit Trail (Compliance-Ready)
Every Workflow Execution produces a complete event history that is:
- **Append-only** — never modified after written
- **Replayable** — can reconstruct full execution from events
- **Searchable** — via custom Search Attributes
- **Traceable** — from initiation through all retries and compensations

### How This Maps to Our Stack
Temporal's events → Prometheus/Grafana (via OpenMetrics) → Langfuse for LLM-specific traces → PostgreSQL for business data → Honcho for agent memory. Every agent action becomes a journaled, auditable event.

Confirmed by _workflow_beyond_agents and https://docs.temporal.io/evaluate/development-production-features/observability.

## Saga Pattern — The Compensating Transaction Guarantee

Temporal implements the **Saga pattern** natively. If a multi-step workflow fails mid-way, Temporal runs compensating activities in reverse order:

```
Create Order        ✓
Reserve Inventory   ✓
Charge Card         ✓
Send Shipment       ✗  ← failure
                   
Compensations:
  Refund Payment
  Release Inventory
  Cancel Order
```

**Why this matters for our agent factory:** When a multi-agent workflow fails mid-way (Coder creates a PR but Reviewer can't review it), Temporal ensures cleanup happens — revert the PR, log the failure, signal the appropriate channel. No zombie state.

## Immediate Wins (Why Deploy Now)

With Temporal running at `127.0.0.1:7233` (Web UI at `:8233`):

1. **Agent workflows survive crashes** — Kill the worker, restart it, the workflow picks up exactly where it left off. Currently any `delegate_task` or cron that takes >5 minutes risks losing work on crash.

2. **Observable dispatch** — Every activity has a timeout + heartbeat. See "subagent dispatched, last check-in 30s ago, retry #2 of 5" instead of "fire and hope."

3. **Long-running state machines** — Multi-hour operations (multi-repo research, E2E test suites, code review pipelines) checkpoint their state. No "start from scratch" after a crash.

4. **Replace cron hacks** — Temporal timers + scheduled workflows + exponential backoff retry replace the current cron + delegate pattern. Failed jobs notify you instead of silently dying.

5. **Forgejo → Temporal → Crumbs** — The PoC's `ProjectWorkflow` (already written and CI-green) creates issues → polls subtasks → publishes to Crumbs. This is the "autonomous project execution harness" we designed.

## Current Deployment Status

| Component | Status | Endpoint |
|-----------|--------|----------|
| Temporal Server (auto-setup) | **Running** (Docker, `--network=host`) | `127.0.0.1:7233` (gRPC) |
| Temporal Web UI | **Running** | `http://127.0.0.1:8233` |
| PostgreSQL (system) | Running | `127.0.0.1:5432` |
| PoC Worker (`hal/temporal-poc`) | Code written, CI-green, not deployed | — |

**Deployment note:** Docker `auto-setup` proved simpler than the Helm chart for single-node dev. The Helm chart's ringpop-based membership required 4 separate pods that couldn't form a cluster reliably on single-node k3s. The auto-setup (all services in one container) avoids this issue entirely.

## Related Pages

- [[autonomous-execution-harness]] — Three-tier task execution model (Temporal is Tier 3)
- _workflow_temporal+nats+crumbs — Original architecture notes
- _workflow_beyond_agents — Temporal vs Cadence vs Saga
- _workflow_langraph — Temporal vs LangGraph
