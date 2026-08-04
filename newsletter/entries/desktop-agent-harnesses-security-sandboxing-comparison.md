---
title: Top 5 Desktop Agent Harnesses: Security, Sandboxing & Integration Comparison
created: 2026-06-17
updated: 2026-06-17
status: draft
tags: [agent-harnesses, desktop-apps, security, sandboxing, codex, claude-cowork, cursor, devin, copilot]
source: research
type: entity
---

# Top 5 Desktop Agent Harnesses: Security, Sandboxing & Integration Comparison

> **tl;dr:** The desktop agent harness landscape in 2026 spans five distinct architectural approaches — from Codex's configurable local sandbox to Devin's fully cloud-isolated autonomous agents, Claude Co-work's folder-scoped VM containment, Cursor's editor-native agent mode, and GitHub Copilot's worktree-based parallel session isolation. The right choice depends on whether your priority is security containment depth, ecosystem integration breadth, or autonomy level.

## 1. OpenAI Codex Desktop

**Released:** macOS Feb 2, 2026 | Windows March 4, 2026
**Pricing:** Bundled with ChatGPT (Free/Go limited, Plus $20/mo, Pro, Business, Enterprise, Edu)

### Security & Sandboxing

Codex Desktop uses **native, open-source, configurable system-level sandboxing** — the same sandbox from Codex CLI, now with a desktop UI. On macOS it uses macOS sandbox primitives; on Windows it ships a **native Windows sandbox** with PowerShell-first workflows. Key controls:

- **Directory access rules:** Restrict which directories Codex can read/write
- **Network access controls:** Allow or block outbound connections
- **Configurable approval modes:** Four modes ranging from fully automatic to per-action approval
- **Team/project rules:** Admins can set policies for which commands run with elevated permissions
- **Open-source sandbox:** The sandboxing code is [open-source on GitHub](https://github.com/openai/codex) for auditability

### Tools & Integrations

- **Skills system:** 110+ curated skills and a dedicated skill creation/management UI — skills bundle instructions, resources, and scripts for repeatable workflows (image generation, web game dev, financial models, etc.)
- **Multi-agent parallel execution:** Agents run in separate threads organized by projects with built-in **Git worktrees** for conflict-free parallel work on the same repo
- **Apps SDK:** Extend Codex with custom application integrations
- **Built-in terminal:** Direct shell access within the app
- **Scheduled automations:** Recurring agent tasks
- **IDE extensions:** VS Code, Cursor, Windsurf, JetBrains
- **ChatGPT sidebar:** Codex accessible from within ChatGPT

### Key Differentiator

The only tool with **native, open-source sandboxing** on both macOS and Windows with configurable enterprise policies. The hybrid local-cloud model means agents can run locally or remotely.

---

## 2. Claude Co-work (Anthropic)

**Released:** Jan 12, 2026 (research preview)
**Pricing:** Claude Pro ($20/mo) or Max ($100–200/mo)

### Security & Sandboxing

Claude Co-work uses Anthropic's **multi-layer containment architecture** detailed in their May 2026 engineering blog:

- **VM-level sandboxing:** Uses Apple's `VZVirtualMachine` (Apple Virtualization Framework) on macOS — a full virtual machine, not just a container. Files are mounted into a containerized/VM environment
- **Folder-scoped access:** Users designate a specific folder; Claude is confined to that directory with no access to system-level files or configurations
- **Three-layer defense:** User misuse → model misbehavior → misaligned output, each with dedicated containment measures
- **Inspectable plans:** Shows a plan of action before execution
- **High-risk action confirmation:** Requires explicit approval for destructive operations
- **Claude Code auto mode:** Automated safer approvals with 83% catch rate on overeager behaviors before execution
- **Reference devcontainer:** For unattended operation without per-action approvals
- **MCP extensions sandboxed:** Desktop extensions and plugins run within the containment boundary

### Tools & Integrations

- **Computer Use:** Direct browser, desktop app, and OS-level interaction
- **Browser Use:** Automated web research and interaction
- **File operations:** Read, create, rename, move, delete files within scoped folder
- **Document/spreadsheet generation:** Create Word docs, spreadsheets with formulas, presentations
- **MCP/desktop extensions:** Expand capabilities through Model Context Protocol plugins
- **Research & Synthesis:** Multi-document analysis and report drafting
- **Claude Code derived:** Inherits all of Claude Code's agentic capabilities in a non-terminal UI

### Key Differentiator

Strongest **VM-level isolation** among desktop agents — true virtual machine containment rather than process-level sandboxing. Best for non-technical knowledge workers who need agentic AI without touching a terminal.

---

## 3. Cursor (Anysphere)

**Released:** VS Code fork, continuously updated (Cursor 3.0 launched Apr 2026, Composer 2.5 May 2026)
**Pricing:** Free tier, Pro ($20/mo), Business ($40/mo)

### Security & Sandboxing

- **Cloud sandboxes for Background Agents:** Agents can run in cloud VMs for long-running tasks, isolated from the local machine
- **No native OS-level sandbox:** Inherits VS Code/Electron security model — the agent operates within the editor process with the same file access as the user's IDE
- **.cursorrules:** Project-level security policies and context rules
- **Privacy controls:** Options for local-only inference and data residency settings
- **Proprietary closed-source agent:** No public sandbox audit trail

### Tools & Integrations

- **Agent Mode (default):** Autonomous multi-file editing and task execution
- **Composer 2.5:** Multi-file orchestration with planning (May 2026)
- **Background Agents:** Cloud-based agents for async tasks
- **Design Mode:** Visual prompt-based UI generation (Jun 2026)
- **BugBot:** Automated PR review agent
- **MCP server integration:** Connect to external tools and infrastructure
- **Tab completion:** AI-powered inline code suggestions
- **Model flexibility:** Supports GPT-5.5, Claude Opus 4.7, Gemini, and custom models
- **8 parallel agents:** Orchestrate up to 8 agents simultaneously

### Key Differentiator

The most mature **AI-native IDE** with the broadest model support. Not a standalone agent harness — it's an editor-first experience, best for developers who want deep codebase integration rather than desktop automation.

---

## 4. Devin Desktop (Cognition AI / acquired Codeium/Windsurf)

**Released:** Devin 2.0 Dec 2025 | Devin 2.2 Feb 2026 | Desktop (Windsurf rebrand) 2026
**Pricing:** Team $500/mo ($6000/yr), ACU billing at $2.25/Agent Compute Unit, Enterprise VPC available

### Security & Sandboxing

- **Fully isolated cloud sandbox:** Devin operates in its own cloud environment with shell + code editor + browser — completely separate from the local machine
- **Desktop computer-use (v2.2):** Can operate local GUI applications through a remote-control protocol, with sandboxed egress
- **Enterprise VPC deployment:** Available for on-premise/private cloud deployment
- **Self-reviewing PRs (Devin Review):** Catches 30% more issues before human review
- **Least-privilege integration:** Opal integration for access control and JIT entitlements
- **No local sandbox risk:** Since execution is cloud-native, local system compromise is not a vector

### Tools & Integrations

- **Full autonomous lifecycle:** Ticket → plan → code → test → debug → PR (end-to-end)
- **Desktop computer-use:** GUI application control (browsers, enterprise software, spreadsheets)
- **Slack integration:** Assign and monitor tasks from chat
- **VS Code extension:** Monitor sessions from within IDE
- **Linear integration:** Bi-directional issue sync
- **Codeium/Windsurf heritage:** Inherits Windsurf's AI IDE capabilities (1M+ users, 4k+ enterprise customers)
- **Parallel cloud agents:** Multiple agents working simultaneously
- **Automations:** Recurring workflows as repeatable templates

### Key Differentiator

The **highest autonomy level** — true fire-and-forget delegation. Operates entirely in the cloud, eliminating local security surface but introducing cloud dependency and highest cost. Best for well-scoped engineering tasks with clear acceptance criteria.

---

## 5. GitHub Copilot App (Microsoft/GitHub)

**Released:** Technical preview May 2026 (Microsoft Build)
**Pricing:** Copilot Pro ($10/mo), Pro+ ($39/mo), Business ($39/user/mo), Enterprise

### Security & Sandboxing

- **Cloud + local sandboxes:** Agents operate in bounded, isolated environments — choice of local or cloud execution
- **Isolated Git worktrees:** Each agent session gets its own git worktree, preventing code collision when multiple agents work the same repository in parallel
- **Agent Merge:** Reviewed merge process for agent-generated changes
- **Copilot SDK across 6 languages:** Built-in security patterns in Python, JS, TS, Go, Java, .NET
- **GitHub ecosystem security:** Inherits GitHub's enterprise security model (SSO, SAML, SCIM, audit log)
- **Codespace integration:** Optional cloud development environment

### Tools & Integrations

- **My Work dashboard:** Unified view of active sessions, issues, PRs, and automations across connected repos
- **Canvas:** Inspectable work-in-progress — live view of what agents are doing
- **Parallel agents:** Multiple agents working simultaneously on different tasks
- **Schedule cloud automations:** Recurring agent workflows
- **MCP integrations:** Connect external tools and APIs
- **Copilot Code Review (medium tier):** Agentic code review with higher-reasoning model
- **Copilot CLI:** Redesigned CLI with voice input and scheduled tasks
- **Agent Merge:** Automated merge with review for agent-generated code
- **Azure DevOps integration:** Native code review on Azure DevOps

### Key Differentiator

**Deepest ecosystem integration** — native GitHub/Azure/Microsoft 365 connectivity. The worktree-based parallel session isolation is the most practical approach for team-scale agent deployment. Newest entrant (weeks old), still in technical preview.

---

## Comparison Matrix

| Feature | Codex Desktop | Claude Co-work | Cursor | Devin Desktop | GitHub Copilot App |
|---|---|---|---|---|---|
| **Sandbox type** | Native OS sandbox (open-source) | VM-level (Apple VZVirtualMachine) | No OS-level (editor process) | Cloud sandbox (fully isolated) | Cloud + local worktree |
| **Desktop availability** | macOS + Windows | macOS | macOS + Windows + Linux | Web + Desktop app | macOS + Windows (preview) |
| **Autonomy level** | Configurable (4 approval modes) | Plan-first + confirmations | In-editor agent | Fire-and-forget | Interactive + auto modes |
| **Parallel agents** | ✅ Per-project threads + worktrees | Single session | ✅ Up to 8 via Composer | ✅ Cloud parallel agents | ✅ Worktree-isolated |
| **Git worktree isolation** | ✅ Built-in | N/A | ❌ Not native | ❌ Cloud environment | ✅ Core feature |
| **Plugin/SDK ecosystem** | Skills system + Apps SDK | MCP extensions | MCP servers | API + integrations | Copilot SDK (6 languages) |
| **Pricing** | $0-20/mo (ChatGPT Plus) | $20-200/mo | $20-40/mo | $500/mo + ACU billing | $10-39/mo |
| **Non-technical UX** | ⭐⭐⭐ (terminal + GUI) | ⭐⭐⭐⭐⭐ (Desktop-first) | ⭐⭐ (IDE-first) | ⭐⭐⭐ (Web + Slack) | ⭐⭐⭐ (Familiar GitHub UX) |
| **Security auditability** | Open-source sandbox | Published containment architecture | Closed-source agent | Enterprise VPC option | GitHub enterprise stack |

---

## Key Takeaways

**For maximum security containment:** Claude Co-work's VM-level isolation or Codex Desktop's open-source native sandbox with configurable approval modes.

**For deepest tool/integration breadth:** Codex Desktop's 110+ skills + Apps SDK, or GitHub Copilot App's Microsoft ecosystem reach.

**For highest autonomy:** Devin Desktop's end-to-end autonomous lifecycle — but at 25x the cost of alternatives.

**For developer-native workflows:** Cursor's agent mode + Composer is the most mature AI coding experience.

**For enterprise compliance:** GitHub Copilot App inherits Microsoft's enterprise compliance (SOC2, FedRAMP, etc.) while Claude Co-work offers the strongest independent containment architecture.

---

## References

- [OpenAI Codex App](https://openai.com/index/introducing-the-codex-app/)
- [Codex on Windows Guide](https://www.digitalapplied.com/blog/codex-windows-native-desktop-agent-sandbox-app-guide)
- [Claude Cowork First Impressions (Simon Willison)](https://simonwillison.net/2026/jan/12/claude-cowork/)
- [How Anthropic Contains Claude Across Products](https://www.anthropic.com/engineering/how-we-contain-claude)
- [Claude Code Sandboxing](https://www.anthropic.com/engineering/claude-code-sandboxing)
- [Cursor Security Analysis](https://agent-safehouse.dev/docs/agent-investigations/cursor-agent)
- [Devin vs Codex Desktop App Comparison](https://www.augmentcode.com/tools/devin-vs-codex-desktop-app)
- [Devin Desktop](https://devin.ai/desktop)
- [GitHub Copilot App: Agent-Native Desktop Experience](https://github.blog/news-insights/product-news/github-copilot-app-the-agent-native-desktop-experience)
- [GitHub Copilot App Technical Preview](https://windowsforum.com/threads/github-copilot-app-preview-desktop-control-center-for-agent-driven-development.421671)
- [Devin 2.2: Desktop and Code Review AI Guide](https://www.digitalapplied.com/blog/devin-2-desktop-code-review-ai-engineer-guide)
- [Best AI Coding Agent Desktop Apps 2026](https://www.augmentcode.com/tools/best-ai-coding-agent-desktop-apps)
