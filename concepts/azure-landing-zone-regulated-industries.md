---
title: Azure Landing Zone for Regulated Industries
created: 2026-06-04
updated: 2026-06-04
type: concept
tags: [azure, landing-zone, financial-services, cloud-architecture, compliance, banking]
sources:
  - raw/articles/azure-landing-zone-financial-services.md
  - raw/articles/azure-policy-nist-sp-800-53-r5.md
---

# Azure Landing Zone for Regulated Industries

## Overview

An **Azure Landing Zone (ALZ)** is the standardized, recommended foundation for any organization adopting Azure at scale. For financial services and banking, the ALZ is particularly critical because it bakes in **security controls, compliance guardrails, and governance** by design — not as afterthoughts.

## Architecture

The ALZ has two tiers:

1. **Platform Landing Zone** — Shared services (identity, connectivity, management) managed by a central team
2. **Application Landing Zones** — Per-workload subscriptions with pre-applied policies and governance

**Supported topologies:** Hub & Spoke, Virtual WAN, Management Group Hierarchy

## Why It Matters for Banking

| Requirement | How ALZ Addresses It |
|---|---|
| NIST SP 800-53 Rev 5 | Azure Policy built-in initiative maps controls to automated policies |
| PCI DSS v4.0.1 | Logging, access control, change detection via Azure Policy and Monitor |
| ISO 27001 | Control implementation via Azure Policy regulatory compliance |
| Data sovereignty | Region-specific deployments, Azure Policy allowed locations |
| Audit trail | Azure Monitor, Log Analytics, Activity Logs by default |

## 8 Key Design Areas

1. Billing & Entra tenant
2. Identity & Access Management (Azure AD, RBAC, PIM)
3. Management group & subscription organization
4. Network topology & connectivity (ExpressRoute, VPN, Azure Firewall)
5. Security (Defender, Sentinel, Key Vault)
6. Management (Monitor, Automation, Update Management)
7. Governance (Azure Policy, Blueprints)
8. Platform automation & DevOps (IaC accelerators: Bicep, Terraform)

## Microsoft for Financial Services Differentiators

- **$1B+ annual security R&D**
- **100+ compliance offerings** — most extensive among CSPs
- Customer-owned data (never used for marketing/advertising)
- Confidential computing and Managed HSMs for sensitive workloads
- Azure Policy NIST SP 800-53 Rev 5 built-in initiative available today

## Deployment Options

| Method | Best For |
|---|---|
| **IaC Accelerator (Terraform/Bicep)** | Repeatable, version-controlled deployments |
| **Portal Accelerator** | Teams without IaC expertise |

## Key Insight

> "From the perspective of Azure landing zones, AI is just another workload or service that can be deployed, governed, and secured within one or more application landing zone subscriptions."

No separate "AI landing zone" needed for banking AI workloads.

## Related

- NIST SP 800-53 Rev 5 — Azure Policy Compliance — Detailed control mapping
- Banking RFP Framework & Best Practices — How to RFP for ALZ
- PCI DSS v4.0.1 Requirements — Continuous monitoring and cloud security
