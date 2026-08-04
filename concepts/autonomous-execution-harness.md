---
title: Autonomous Execution Harness — Abstraction Analysis
created: 2026-05-30
updated: 2026-05-30
type: concept
tags: [autonomous-execution, task-execution, project-orchestration, ralph-loop, research-loop, architecture]
status: draft
sources: []
---

# Autonomous Execution Harness — Abstraction Analysis

## Scope

This page defines the core abstraction of the autonomous execution harness being built — distinct from any single vendor platform (Hermes, Codex, Claude Code, Devin, etc.). The harness is the **task/job/project execution layer** that can outlast any vendor runtime.

## The Three Tiers

All three are the same abstraction at different scale:

```
                Duration     Concurrency     Success criteria
Tier 1 (Ralph): minutes      1 agent         Judge heuristic
Tier 2 (Auto):  hours        1 agent         Metric-threshold verification
Tier 3 (Proj):  days         N agents        Multi-condition outcome + artifact trail
```

### Tier 1: Ralph Loop
Single agent, single task, auto-continue until done or budget exhausted.
**Current capability:** Hermes `/goal` implements this (20-turn default budget, judge model). Ralph Wiggum skill adds retry-with-bail at each step.
**Gaps:** Judge is heuristic (reads agent output, doesn't check external state). No cost/token/time bounding.

### Tier 2: Auto-Research / Experiment Loop
Agent runs experiments toward a well-defined metric. Hypothesis → experiment → measure → iterate. Budget bounded by time, cost, or tokens, not just turn count.
**Current capability:** No native primitive. Approximatable via cron + metric-check script + agent delegation.
**Gaps:** Metric-based success criteria require an external verifier hook. No experiment history/tracking. No automated termination on budget exhaustion.

### Tier 3: Long-Lived Multi-Step Projects
Multi-agent, cross-session, multi-step work toward a complex outcome. Project state persists. Work is dispatched across agents, time, and sessions.
**Current capability:** No native primitive. Components exist (cron, delegate_task, Crumbs, Forgejo) but no orchestrator tying them together.
**Gaps:** Project orchestrator missing. Session-surviving execution missing. Multi-agent coordination limited (max 3 parallel children, max_spawn_depth=1, orchestrator role disabled). Outcome verification heuristic-only.

## Key Design Axes

| Axis | Range | Notes |
|------|-------|-------|
| **Duration** | Seconds → days | Determines persistence strategy |
| **Concurrency** | 1 → N agents | Determines coordination model |
| **Success criteria** | Heuristic → metric → multi-condition | Determines verifier interface |
| **Budget type** | Turns → time → cost → tokens | Determines termination logic |
| **State** | Ephemeral → durable (DB) | Determines recovery model |
| **Observability** | None → full tracing | Determines debug/debug-ability |

## What the Current Stack Provides

| Component | Role in harness |
|-----------|----------------|
| **Hermes Agent** (Riki) | Chief-of-Staff runtime, orchestration, research, spec authoring |
| **Forgejo** | Git hosting, issue tracking, CI/CD pipelines, PR workflow |
| **Forgejo Actions** | Containerized execution for build/test/deploy phases |
| **Crumbs** | Kanban/task state, project tracking, single pane of glass |
| **Cron jobs** | Scheduled agent execution, survives sessions |
| **delegate_task** | Subagent spawning (max 3 parallel, leaf-only) |
| **Skills** | Reusable procedural knowledge |
| **LLM-Wiki** (auto_memex) | Persistent knowledge base for research context |
| **DarkForge** | Autonomous software factory harness |

## What's Missing (Primitive Gap)

1. **Unified primitive** — A single abstraction that spans all three tiers with graduated complexity
2. **External verifier interface** — Script-hook or API-call that checks if a goal's success criteria is met (vs. heuristic judge)
3. **Cost/token/time budgeting** — Not just turn count; real dollar, token, or wall-clock limits
4. **Multi-agent DAG** — Task dependency graph where completion of A triggers start of B, with parallel fan-out
5. **Session-surviving project state** — A project that starts in one session and continues across resets, survives reboots
6. **Outcome verification registry** — Historical record of what outcomes were set, what was achieved, what drifted
7. **Experiment tracking** — Hypothesis, parameters, results, metrics persisted for analysis

## Design Principle

> **No vendor platform (Hermes, Codex, Claude Code, OpenClaw, Devin) will permanently meet requirements. The harness must be an abstraction layer that can swap any execution backend.**

Vendor platforms are component candidates:
- Hermes = CoS runtime + tool ecosystem
- Codex/OpenClaw = implementation subagents  
- Forgejo = artifact store + CI
- Temporal.io (future) = durable execution for long-lived projects
- gVisor/Firecracker (future) = sandboxed execution

The abstraction survives the vendor.

---

## 2026 Landscape Research

Research conducted 2026-05-30 across four domains: durable execution, multi-agent orchestration, sandboxing, and runtime verification.

### Durable Execution (Temporal)

**Key pattern emerging:** Workflow-as-code with automatic state persistence, retries, signals, and timers. Used in production by OpenAI, Replit, Cursor, Lovable, Retool.

| Capability | What it means for the harness |
|---|---|
| **State persistence** | Workflow survives process crash and machine restart — state is journaled |
| **Retry policies** | Built-in exponential backoff, max retries, non-retryable error types |
| **Signals** | External systems can message a running workflow mid-execution |
| **Timers** | Schedule future actions, timeouts, delays without cron infrastructure |
| **Durable MCP** | MCP tool calls executed durably — if the tool call crashes, Temporal retries it |
| **Multi-agent routing** | Shepherd agent routes between specialist agents, all within one durable workflow |

**Relevance: Temporal directly fills Tier 3 gap.** No other component in the current stack provides session-surviving, fault-tolerant project orchestration. The workflow-as-code primitive is the missing orchestrator.

### Multi-Agent Orchestration (2026 Landscape)

The framework landscape has consolidated. From 18+ production deployments (Alice Labs, MadAppGang, Turion):

| Framework | Role | Production readiness | Best for |
|---|---|---|---|
| **LangGraph** | Graph-based orchestration | 5/5 | Complex stateful workflows, conditional branching |
| **Claude Agent SDK** | Model-native agent runtime | 4/5 | Anthropic-native production agents (powers Claude Code) |
| **CrewAI** | Role-based team composition | 3/5 | Multi-agent crews with defined roles |
| **AutoGen/AG2** | Conversational research | 4/5 | Research-style agent conversations, multi-perspective |

**Consensus:** No single framework is the answer. Production teams compose multiple frameworks — LangGraph for orchestration, Claude SDK for execution, Strands for lightweight agents. The differentiator is "how a framework models **time, memory, and failure**" (MadAppGang, 2026).

### Sandboxed Execution

| Approach | Isolation level | Performance | Examples |
|---|---|---|---|
| **Firecracker microVM** | Hardware-level (dedicated kernel) | ~125ms start, near-native | E2B, Fly.io, Vercel Sandbox |
| **gVisor** | User-space kernel (syscall interception) | ~5-10% overhead | Daytona, Northflank |
| **Kata Containers** | Lightweight VM per container | Moderate | Northflank, GKE Agent Sandbox |
| **Hardened containers** | Kernel-sharing (seccomp, AppArmor) | Minimal | Docker — only for trusted code |

**E2B SDK** is the reference "AI agent sandbox" library — Python/JS SDKs, self-hostable Firecracker backend, snapshot/resume support.

**Relevance:** Today we use Docker containers with `--security-opt seccomp=unconfined` for CI runner. This is fine for trusted build code but **inadequate for untrusted agent-generated code**. Sandbox isolation is an unresolved risk for the harness.

### Runtime Verification

The 2026 shift: from "trust the prompt" to "trust, but verify." Key trends:

- **Policy-as-code** for agent actions — what operations are allowed/denied at runtime
- **Observation + rollback** — watch what the agent does, revert on policy violation
- **GKE Agent Sandbox** announced at Google Cloud Next '26 — Google's managed sandbox for secure agent code execution
- **Formal verification** for agent workflows is still early-stage — mostly academic

### Pipeline Architecture (No Duplication)

The three systems form a **pipeline, not parallel alternatives**:

```
┌──────────────────────────────────────────────────────────────────┐
│  Crumbs (Kanban)         ← user-facing project/task state        │
│       ↕                      single pane of glass                │
│  Forgejo (Git/CI/Issues) ← artifact store + pipeline execution   │
│       ↕                      persistent, versioned               │
│  Temporal (Durable Exec)  ← workflow orchestrator + state        │
│       ↕                      survives crashes, retries tasks     │
│  Agent runtime             ← actual work executor (Hermes/Codex) │
└──────────────────────────────────────────────────────────────────┘
```

**Roles are distinct:**
- **Temporal** = *does* the work (orchestrates durable workflows, retries on failure)
- **Crumbs** = *shows* the work (kanban, project state, single pane of glass)
- **Forgejo** = *stores* the work artifacts (git, issues, CI runs, automation)
- **fj-eventbus** = *bridges* Forgejo events → Crumbs automatically (zero manual sync)

**No duplication:** When Temporal completes a workflow step, it signals to Crumbs (user sees it). The same event hits Forgejo Issues (artifact trail). The eventbus bridge ensures Crumbs and Forgejo stay consistent without manual effort.

Same layering for Tiers 1 and 2:

```
Tier 3 (Projects)     Temporal orchestrator → Crumbs (via eventbus)
Tier 2 (Research)     Shared-state agent loop → Crumbs (via eventbus)
Tier 1 (Ralph)        Vendor agent loop → Crumbs (via eventbus)
Layer 0 (Runtime)     Hermes Agent (Riki) — CoS, tool ecosystem, skills
```

Each layer is independently replaceable. The abstraction survives any vendor swap. Crumbs remains the single pane of glass regardless.

---

## Unknown Unknowns (What We Haven't Considered)

1. **Durable execution as a first-class primitive** — We have Forgejo CI (push-triggered) and cron jobs, but no workflow-as-code that survives host machine crashes. Temporal introduces exactly this — the project lives even if the machine dies.

2. **Sandbox isolation strategy** — Docker containers with permissive seccomp profiles work for trusted CI code but are inadequate for untrusted agent-generated code. No sandbox strategy exists for the case where an agent writes and runs arbitrary scripts.

3. **Formal outcome verification** — All three tiers currently rely on "agent says done" (heuristic). No property-based testing, invariant checking, or metric-threshold monitoring is wired into the task loop. For Tier 2 (research) and Tier 3 (projects), this is the critical gap.

4. **Cost/budget modelling** — No native per-task or per-project cost tracking. Turn count is the only budget we can enforce. Token spend, API cost, or wall-clock time limits don't exist.

5. **Observability at the task/project level** — Grafana covers infrastructure metrics. There is no tracing across agent calls within a project, no span tree showing "this research step → this experiment → this result."

6. **Federated agent hierarchy** — Current max: 3 parallel children with flat delegation (max_spawn_depth=1, orchestrator role disabled). No tree-structured agent spawning (orchestrator → team leads → workers). This caps Tier 3's concurrency model.

7. **Human-in-the-loop at workflow level** — Current HITL is binary (y/n for destructive commands). No workflow-level review gates, no diff approval passthrough, no staged escalation for critical junctures.

8. **Event-driven triggers** — No file watchers, webhook-to-agent flows, or metric-threshold-triggered task creation. Everything is either push-to-Forgejo or cron-on-schedule.

9. **Agent-generated code safety** — No static analysis, AST scanning, or policy enforcement before executing agent-written code. The sandbox question covers runtime; pre-execution scanning is a separate gap.

10. **Multi-model routing** — No routing agent that selects the best model/backend per task type based on capability, cost, and latency profiles.

---

## Next Research Directions

1. Hands-on evaluation of Temporal for durable agent workflows (Tier 3 proof-of-concept)
2. E2B self-hosting evaluation for sandboxed agent execution
3. LangGraph evaluation for complex task DAG orchestration (Tier 2/3)
4. Cost modelling framework — capture per-task token/cost/spend data
5. Runtime verification policy engine — what operations are allowed/denied for agents
