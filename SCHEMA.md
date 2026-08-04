---
title: Wiki Schema
created: 2026-04-12
updated: 2026-04-17
modified: 2026-04-17
type: schema
tags: [DevOps, AI, Security, Blockchain, Networking, Data, Web]
---
# Wiki Schema

## Domain
IT Service Startup Operations - covering AI/ML applications, IT Security, Cloud Infrastructure, Software Development, and MSP/MSSP business operations.

## Conventions
- File names: lowercase, hyphens, no spaces (e.g., `zero-trust-architecture.md`)
- Every wiki page starts with YAML frontmatter (see below)
- Use `wikilinks` to link between pages (minimum 2 outbound links per page)
- When updating a page, always bump the `updated` date
- Every new page must be added to `index.md` under the correct section
- Every action must be appended to `log.md`

## Frontmatter
  ```yaml
  ---
  title: Page Title
  created: YYYY-MM-DD
  updated: YYYY-MM-DD
  type: entity | concept | comparison | query | summary | transcript
  tags: [from taxonomy below]
  sources: [raw/articles/source-name.md]
  ---
  ```

## Tag Taxonomy
[Define 10-20 top-level tags for the domain. Add new tags here BEFORE using them.]

### Technology
- **AI/ML**: ai, ml, ai-research, ai-engineering, data-science, mlops, llm-wiki, knowledge-base, research-method, uncategorized, llm, transformer, autonomous-execution, task-execution, project-orchestration, ralph-loop, research-loop, ai-agents, hermes-agent, agent-harnesses, codex, gpt-5, executive-productivity, data
- **Cloud**: cloud, cloud-computing, aws, paas, iaas, serverless, netflix, azure, landing-zone, financial-services, cloud-architecture
- **Security**: security, it-security, cybersecurity, zero-trust, iam, edr, sip, vulnerability, compliance, incident-response, haveibeenpwned, nist, azure-policy, regulatory, security-controls, pci-dss, client-side-security, payment-security, blockchain
- **Development**: devops, ci/cd, microservices, api, containerization, iac, software-development, backend-engineering, faang, coding-interview, jboss, wildfly, migration, java-ee, middleware, desktop-apps, sandboxing, claude-cowork, cursor, devin, copilot, web
- **Infrastructure**: networking, virtualization, monitoring, backup, dr, rmm, psa, ticketing, automation, architecture, network, remote-access, twingate, temporal, durable-execution, workflow-orchestration, saga-pattern, observability, audit-trail, nats, langgraph, infrastructure

### Business
- msp, mssp, saas, consulting, managed-services, pricing, sla, vendor-review, banking, rfp, procurement, vendor-selection, governance, scoring, evaluation

### Content & People
- influencer, youtube, blogger, author, cryptographer, podcaster, cloud-economist, tech-commentary, technology-evangelist, cloud-advocate, udemy

### Meta
- comparison, timeline, trend, prediction, research-method, uncategorized, log

Rule: every tag on a page must appear in this taxonomy. If a new tag is needed,
add it here first, then use it. This prevents tag sprawl.

## Page Thresholds
- **Create a page** when an entity/concept appears in 2+ sources OR is central to one source
- **Add to existing page** when a source mentions something already covered
- **DON'T create a page** for passing mentions, minor details, or things outside the domain
- **Split a page** when it exceeds ~200 lines — break into sub-topics with cross-links
- **Archive a page** when its content is fully superseded — move to `_archive/`, remove from index

## Entity Pages
One page per notable entity. Include:
- Overview / what it is
- Key facts and dates
- Relationships to other entities (wikilinks)
- Source references

## Concept Pages
One page per concept or topic. Include:
- Definition / explanation
- Current state of knowledge
- Open questions or debates
- Related concepts (wikilinks)

## Comparison Pages
Side-by-side analyses. Include:
- What is being compared and why
- Dimensions of comparison (table format preferred)
- Verdict or synthesis
- Sources

## Update Policy
When new information conflicts with existing content:
1. Check the dates — newer sources generally supersede older ones
2. If genuinely contradictory, note both positions with dates and sources
3. Mark the contradiction in frontmatter: `contradictions: [page-name]`
4. Flag for user review in the lint report

## Queue JSON Schema
Task queue for content ingestion. File: `content_queue.json`

```json
[
  {
    "id": "EWvNQjAaOHw",
    "url": "https://www.youtube.com/watch?v=EWvNQjAaOHw",
    "type": "transcript",
    "title": "How I use LLMs",
    "channel": "andrej-karpathy",
    "duration": 7872.0,
    "status": "Unassigned | Open | Processing | Done | Failed",
    "added": "2026-04-21T12:20:54.019260",
    "error": null
  }
]
```

### Field Definitions
| Field | Type | Required | Description |
|-------|------|----------|------------|
| `id` | string | yes | YouTube video ID or unique source ID |
| `url` | string | yes | Full URL to source |
| `type` | string | yes | `transcript`, `article`, `paper` |
| `title` | string | yes | Display title |
| `channel` | string | no | Source channel/author |
| `duration` | float | no | Duration in seconds |
| `status` | string | yes | Current state in pipeline |
| `quality_score` | integer | no | Computed quality score 1-100. Lower = less processed content. Higher = richer material. |
| `added` | string | yes | ISO timestamp when enqueued |
| `error` | string | no | Error message if failed |

## Environment Variables
| Variable | Default | Description |
|----------|---------|------------|
| `WIKI_VAULT` | `~/library` | Vault root directory |
| `WIKI_QUEUE_FILE` | `{vault}/content_queue.json` | Queue file path |
| `WIKI_RAW_DIR` | `{vault}/raw` | Raw content directory |

## Scoring

Quality scores are computed by `ingest_source.py --content` or passed directly with `--score`. Score components:
- Baseline: 30
- Length: +10 (200+ words), +20 (500+ words)
- Structure: +min(15) from headings, +min(15) from lists


- Title: +10 (if present and >5 chars)


- URLs: +min(10) from links
- Short penalty: -20 (under 50 words)

**Filter is disabled** — all content scoring > 0 is enqueued. The score is stored for future filtering, prioritization, or triage decisions by the user.

## Raw Content Format

### YouTube Video (`raw/transcripts/{channel}/{video_id}.md`)
Full content with metadata block.

```markdown
# {channel} - {video_id}

Source: https://youtube.com/watch?v={video_id}
Fetched: {ISO timestamp}
Duration: {HH:MM:SS}
Published: {YYYYMMDD}
Views: {count}

---

{FULL TRANSCRIPT CONTENT}
[00:00] Intro paragraph
[00:15] Next topic
[00:30] Key point

---

## Metadata
- Channel: {channel}
- Published: {YYYYMMDD}
- Duration: {HH:MM:SS}
- Views: {count}
- Video ID: {video_id}
```

### Written Content (`raw/articles/{slug}.md`)
Source article with metadata.

```markdown
# {Article Title}

Source: {URL}
Fetched: {ISO timestamp}
Author: {author}

---

{FULL ARTICLE CONTENT}

---

## Metadata
- Author: {author}
- Published: {YYYY-MM-DD}
- URL: {URL}
```

## Build Page Format

Generated `concepts/{slug}.md` must include these sections:

```markdown
---
title: {title}
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: concept
tags: [extracted, tags]
sources: [raw/transcripts/channel/video-id.md]
tier: {S|A|B|C|D}
quality_score: {1-100}
---

# {title}

## Summary
2-3 sentence overview (REQUIRED)

## Key Concepts
- concept 1
- concept 2
- concept 3 (REQUIRED: minimum 1)

## Action Items / Insights
- actionable insight 1 (RECOMMENDED)
- actionable insight 2

## People Mentioned
- Name: context (RECOMMENDED)

## Resources
- resource-name: URL (RECOMMENDED)

## Full Transcript
{{raw/transcripts/{channel}/{video_id}.md}} (REQUIRED: link to raw source)

## Related Concepts
- related-concept-1
- related-concept-2 (REQUIRED: minimum 1)
```

## Lint Rules

### Required Sections
| Rule | Check |
|------|-------|
| `has-summary` | Summary section exists with 2+ sentences |
| `has-concepts` | Key Concepts section ≥ 1 item |
| `has-transcript-link` | Full Transcript links to raw source file |
| `has-related` | Related Concepts ≥ 1 wikilink |

### Recommended Sections
| Rule | Check |
|------|-------|
| `has-action-items` | Action Items ≥ 1 item |
| `has-people` | People Mentioned ≥ 1 (or none if not applicable) |
| `has-resources` | Resources section with valid URLs |

### Content Validation
| Rule | Check |
|------|-------|
| `valid-frontmatter` | All required frontmatter fields present |
| `valid-tags` | All tags in taxonomy |
| `valid-sources` | Source files exist |