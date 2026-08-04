---
title: NIST SP 800-53 Rev 5 — Azure Policy Compliance
created: 2026-06-04
updated: 2026-06-04
type: concept
tags: [nist, azure-policy, compliance, regulatory, security-controls, banking]
sources:
  - raw/articles/azure-policy-nist-sp-800-53-r5.md
---

# NIST SP 800-53 Rev 5 — Azure Policy Compliance

## Overview

Azure's **Regulatory Compliance built-in initiative** for NIST SP 800-53 Rev 5 maps each control to Azure Policy definitions. For a banking platform on Azure, this is the primary mechanism for **automated compliance evidence** — it continuously assesses whether deployed resources conform to NIST controls.

> **Important limitation:** Azure Policy compliance is only a **partial view** of overall compliance. It covers what Azure can detect automatically — customer-side controls (policies, procedures, training) are assessed separately.

## Control Families Covered

| Family | Key Controls | Automated Coverage |
|---|---|---|
| **AC** — Access Control | Account management, access enforcement, information flow, least privilege | RBAC audit, managed identity enforcement, Private Link, NSGs, JIT access |
| **AU** — Audit & Accountability | Audit record content, review/analysis, generation | Log Analytics workspace, diagnostics settings, Activity Log |
| **CM** — Configuration Management | Baseline configuration, least functionality, component inventory | Azure Policy assignments, allowed resources, VM image compliance |
| **CP** — Contingency Planning | Alternate processing site, backup, recovery | Azure Site Recovery, Azure Backup, geo-redundant storage |
| **IA** — Identification & Authentication | User identification, authenticator management, MFA | Azure AD, MFA policies, password policies |
| **SI** — System & Information Integrity | Flaw remediation, system monitoring, integrity | Update management, vulnerability assessment, Defender, Sentinel |

## Responsibility Model

- **Customer** — Policy/procedure controls (e.g., AC-1 policy development)
- **Microsoft** — Infrastructure controls (e.g., physical security)
- **Shared** — Hybrid controls (e.g., AC-2 account management — MS handles platform, customer handles app accounts)

## Using in the Banking RFP

The RFP response should:
1. **Map each NIST control** to either Azure Policy automation or a customer-side control
2. **Reference specific Azure Policy definitions** (e.g., "Azure Defender for SQL — covers AU-12(1)")
3. **Acknowledge the gap** — Azure Policy is not a complete compliance solution
4. **Include a manual control matrix** for controls Azure cannot assess

## Accessing the Initiative

**Azure portal:** Policy → Definitions → NIST SP 800-53 Rev 5
**GitHub:** https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Regulatory%20Compliance/NIST_SP_800-53_R5.json

## Related

- Azure Landing Zone for Regulated Industries — ALZ architecture for banking
- PCI DSS v4.0.1 Requirements — PCI control implementation
- Banking RFP Framework & Best Practices — Compliance-as-Code in evaluation criteria
