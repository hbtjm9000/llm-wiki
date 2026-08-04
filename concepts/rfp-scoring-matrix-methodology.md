---
title: RFP Scoring Matrix Methodology
created: 2026-06-04
updated: 2026-06-04
type: concept
tags: [rfp, scoring, evaluation, procurement, banking, vendor-selection]
sources:
  - raw/articles/banking-rfp-scoring-matrix.md
  - raw/articles/banking-rfp-checklist-investglass.md
---

# RFP Scoring Matrix Methodology

## Overview

A **weighted scoring matrix** is the standard tool for evaluating banking RFP responses. It ensures objective, transparent, and auditable vendor selection. For banking RFPs, the matrix must be defensible to regulators — every weight, every score, and every decision must have documented rationale.

## Three-Stage Evaluation Model (Banking Recommended)

### Stage 1: Mandatory Gate (Pass/Fail)
Not scored — vendors who fail ANY mandatory requirement are disqualified:
- Minimum compliance certifications (ISO 27001, SOC 2 Type II)
- Data sovereignty / local residency
- Regulatory licenses
- Financial stability / banking experience

### Stage 2: Weighted Technical Scoring
The core evaluation. Multiple assessors independently score, scores are averaged:

| Criteria | Weight | Scoring Focus |
|---|---|---|
| Security, Compliance & Data Sovereignty | **30%** | Certifications, encryption, data residency, audit |
| Technical Capability & Integration | 25% | Architecture fit, API maturity, cloud platform |
| Pricing & Cost Transparency | 20% | TCO, licensing model, hidden costs |
| Implementation & Migration Expertise | 10% | Migration method, timeline realism |
| Service Quality & Support | 8% | SLAs, incident response, training plan |
| Vendor Stability & Fit | 7% | Banking track record, financial health, exit terms |

### Stage 3: Finalist Deep-Dive
Shortlist (2-3 vendors) proceed to:
- Product demo with live banking scenarios (weighted against technical criteria)
- Reference checks with existing banking clients
- Management interview
- Final pricing negotiation

## Scoring Scale

| Score | Meaning |
|---|---|
| 0 | No response / Non-compliant |
| 1–3 | Significant gaps, high risk |
| 4–6 | Meets baseline, no differentiators |
| 7–8 | Strong, minor gaps |
| 9–10 | Exceptional, exceeds requirements |

## Calculation Example

```
Vendor A:
  Security/Compliance:       9 × 0.30 = 2.70
  Technical Capability:      8 × 0.25 = 2.00
  Pricing:                   7 × 0.20 = 1.40
  Implementation:            8 × 0.10 = 0.80
  Service/Support:           6 × 0.08 = 0.48
  Vendor Stability:          7 × 0.07 = 0.49
                              ─────────────
                      Total:           7.87 / 10
```

## Best Practices

1. **Publish weights in the RFP** — lets vendors prioritize correctly
2. **At least 3 evaluators** per criterion — average scores, flag outliers
3. **Document every score** — spreadsheet with justification column
4. **Use calibrated scoring** — brief the evaluation team on what each score level means before scoring starts
5. **Include qualitative notes** — scores need narrative context for audit

## Pitfalls to Avoid

- **Cost weight > 25%** — leads to selecting on price alone, high regret rate
- **Pass/fail criteria buried in scoring** — mandatory requirements must be gates, not scored items
- **Evaluator bias** — cross-functional team required; never one person scoring alone
- **No exit term scoring** — banking RFPs must evaluate lock-in risk and data portability

## Related

- Banking RFP Framework & Best Practices — Full RFP framework context
- PCI DSS v4.0.1 Requirements — The 30% compliance weighting explained
