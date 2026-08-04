---
title: PCI DSS v4.0.1 Requirements
created: 2026-06-04
updated: 2026-06-04
type: concept
tags: [pci-dss, compliance, banking, security, client-side-security, payment-security]
sources:
  - raw/articles/pci-dss-v4-0-1-banking-2026.md
  - raw/articles/banking-rfp-checklist-investglass.md
---

# PCI DSS v4.0.1 Requirements

## Overview

PCI DSS v4.0.1 is the active version of the Payment Card Industry Data Security Standard (as of 1 January 2025). It represents a fundamental shift from **point-in-time checklist compliance** to **continuous, risk-based security**. For online banking platforms, this is the governing compliance framework.

> "PCI DSS v4.0.1 is not merely a compliance update—it is a shift toward continuous security, risk-based controls, and executive accountability."

## The Fundamental Shift

| v3.2.1 (Old) | v4.0.1 (Current) |
|---|---|
| Annual audit snapshot | Continuous monitoring |
| Checkbox compliance | Risk-based controls |
| IT responsibility | Board-level governance |
| Fixed requirements | Flexibility with justification |
| Periodic scans | Real-time detection + alerting |

## Critical Requirements for Online Banking

### Requirement 6.4.3 — Payment Page Script Management (mandatory April 2025)

All payment page scripts must be:
1. **Authorized** — Whitelist with approval mechanism
2. **Integrity-checked** — SHA-256 hashing, Sub-Resource Integrity (SRI)
3. **Inventoried** — Complete list with written justification per script

Third-party scripts are the highest risk vector — Magecart-style skimming attacks target exactly this.

### Requirement 11.6.1 — Change and Tamper Detection (mandatory April 2025)

Deploy a detection mechanism that:
- Alerts on unauthorized modifications to HTTP headers and payment page content
- Evaluates pages as received by the consumer browser
- Runs **at least every 7 days** (or per risk analysis)

**Implementation approaches:**
- CSP Violation Reporting (`report-to` / `report-uri`)
- Synthetic User Monitoring (SUM)
- Tamper-resistant scripts
- Reverse proxy / CDN change detection

## Cloud Security Implications

v4.0.1 places **greater scrutiny on cloud infrastructure** (Azure, AWS, GCP). For a banking cloud migration:
- Shared responsibility model must be explicitly documented
- Customer-controlled encryption keys (Azure Key Vault / HSM)
- Cloud WAF and CSP configuration
- Vendor risk management extends to cloud provider

## Key Takeaways for the RFP

1. Script integrity is now a **mandatory, auditable control** — not a best practice
2. The RFP response must name specific tools/approaches for 6.4.3 and 11.6.1
3. Cloud security posture is explicitly in scope — Azure Policy, Defender, Sentinel
4. Board-level accountability means the RFP evaluation committee must include executive representation
5. Continuous compliance evidence replaces annual snapshot — the platform must generate evidence automatically

## Related

- Banking RFP Framework & Best Practices — How to reflect PCI in evaluation criteria
- Azure Landing Zone for Regulated Industries — Cloud foundation for PCI workloads
- [[RFP Scoring Matrix Methodology]] — Weighting compliance at 30%
