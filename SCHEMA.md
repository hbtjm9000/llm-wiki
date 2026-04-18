---
title: Wiki Schema
created: 2026-04-12
updated: 2026-04-17
modified: 2026-04-17
type: schema
tags:
  - DevOps
  - AI
  - Security
  - Blockchain
  - Networking
  - Data
  - Web
---
# Wiki Schema

## Domain
IT Service Startup Operations - covering AI/ML applications, IT Security, Cloud Infrastructure, Software Development, and MSP/MSSP business operations.

## Conventions
- File names: lowercase, hyphens, no spaces (e.g., `zero-trust-architecture.md`)
- Every wiki page starts with YAML frontmatter (see below)
- Use `[[wikilinks]]` to link between pages (minimum 2 outbound links per page)
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
- **AI/ML**: ai, ml, ai-research, ai-engineering, data-science, mlops, llm-wiki, knowledge-base, research-method
- **Cloud**: cloud, cloud-computing, aws, paas, iaas, serverless, netflix
- **Security**: security, it-security, cybersecurity, zero-trust, iam, edr, sip, vulnerability, compliance, incident-response, haveibeenpwned
- **Development**: devops, ci/cd, microservices, api, containerization, iac, software-development, backend-engineering, faang, coding-interview
- **Infrastructure**: networking, virtualization, monitoring, backup, dr, rmm, psa, ticketing, automation

### Business
- msp, mssp, saas, consulting, managed-services, pricing, sla, vendor-review

### Content & People
- influencer, youtube, blogger, author, cryptographer, podcaster, cloud-economist, tech-commentary, technology-evangelist, cloud-advocate, udemy

### Meta
- comparison, timeline, trend, prediction, research-method

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
- Relationships to other entities ([[wikilinks]])
- Source references

## Concept Pages
One page per concept or topic. Include:
- Definition / explanation
- Current state of knowledge
- Open questions or debates
- Related concepts ([[wikilinks]])

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