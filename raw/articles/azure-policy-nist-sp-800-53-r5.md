---
title: Azure Policy NIST SP 800-53 Rev 5 Regulatory Compliance
source: https://learn.microsoft.com/en-us/azure/governance/policy/samples/nist-sp-800-53-r5
retrieved: 2026-06-04
type: raw-article
tags: [nist, azure-policy, compliance, regulatory, security-controls]
---

# Azure Policy — NIST SP 800-53 Rev 5 Regulatory Compliance Built-in Initiative

**Source:** https://learn.microsoft.com/en-us/azure/governance/policy/samples/nist-sp-800-53-r5
**GitHub:** https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Regulatory%20Compliance/NIST_SP_800-53_R5.json

---

## Overview

Azure provides a built-in Regulatory Compliance initiative that maps NIST SP 800-53 Rev. 5 controls to Azure Policy definitions. This enables automated compliance assessment for Azure deployments.

### Critical Disclaimers (verbatim from Microsoft)

- "There often is not a one-to-one or complete match between a control and one or more policies"
- "**Compliant** in Azure Policy refers only to the policy definitions themselves; this doesn't ensure you're fully compliant with all requirements of a control"
- "The compliance standard includes controls that aren't addressed by any Azure Policy definitions at this time"
- "Compliance in Azure Policy is only a partial view of your overall compliance status"

---

## Compliance Domains Covered

### Access Control (AC)

| Control | Description | Key Automated Policies |
|---|---|---|
| AC-1 | Policy and Procedures | Manual (CMA policy definitions) |
| AC-2 | Account Management | Max 3 subscription owners, AAD admin for SQL, managed identity for App/Function apps, deprecated accounts removed, guest accounts removed, Service Fabric AAD auth |
| AC-2(12) | Atypical Usage Monitoring | Azure Defender for App Service/SQL/Key Vault/Storage/Containers, JIT network access |
| AC-3 | Access Enforcement | SSH key auth for Linux VMs, AI Services local auth disabled, RBAC on Kubernetes |
| AC-4 | Information Flow Enforcement | All internet traffic via Azure Firewall, NSGs on subnets/VMs, Private Link for 25+ services |
| AC-6 | Least Privilege | Audit usage of custom RBAC roles |

### Audit and Accountability (AU)

| Control | Description |
|---|---|
| AU-3 | Content of Audit Records — log analytics workspace configuration |
| AU-6 | Audit Review, Analysis, and Reporting — Azure Monitor + Sentinel |
| AU-12 | Audit Generation — Azure Monitor Agent, diagnostic settings |

### Configuration Management (CM)

| Control | Description |
|---|---|
| CM-2 | Baseline Configuration — Azure Policy enforces baseline |
| CM-7 | Least Functionality — VM image compliance, allowed locations |
| CM-8 | Information System Component Inventory — Azure Resource Graph |

### Contingency Planning (CP)

| Control | Description |
|---|---|
| CP-7 | Alternate Processing Site — Azure Site Recovery, paired regions |
| CP-9 | Information System Backup — Azure Backup, geo-redundant storage |
| CP-10 | System Recovery and Reconstitution — Azure Site Recovery, automation runbooks |

### Identification and Authentication (IA)

| Control | Description |
|---|---|
| IA-2 | Identification and Authentication (Organizational Users) — Azure AD, MFA |
| IA-5 | Authenticator Management — Password policies, key rotation |
| IA-8 | Identification and Authentication (Non-Organizational Users) — B2B collaboration |

### System and Information Integrity (SI)

| Control | Description |
|---|---|
| SI-2 | Flaw Remediation — Update management, vulnerability assessment |
| SI-4 | System Monitoring — Azure Monitor, Defender, Sentinel |
| SI-7 | Software, Firmware, and Information Integrity — File integrity monitoring |

---

## How to Access

1. Azure portal → Policy → Definitions
2. Search for "NIST SP 800-53 Rev 5"
3. Review initiative definition and assigned policies
4. Assign to management group or subscription for compliance assessment

### GitHub Change History

Track changes to the initiative definition:
https://github.com/Azure/azure-policy/commits/master/built-in-policies/policySetDefinitions/Regulatory%20Compliance/NIST_SP_800-53_R5.json

---

## Responsibility Model

Controls are assigned one of three ownership types:
- **Customer** — Customer implements and manages
- **Microsoft** — Microsoft implements and manages
- **Shared** — Both parties share responsibility

---

## Key Takeaways for Banking RFP

1. Azure Policy provides a **built-in** NIST SP 800-53 Rev 5 compliance initiative
2. It covers all major control families: AC, AU, CM, CP, IA, SI, etc.
3. Manual controls (policies exist but require human action) are flagged with type "Manual, Disabled"
4. Not a complete compliance solution — only a partial view
5. Must be combined with customer-side controls for full compliance
6. The initiative is versioned and tracked via GitHub
7. For banking RFPs, reference this as **automated compliance evidence**, not a compliance guarantee
