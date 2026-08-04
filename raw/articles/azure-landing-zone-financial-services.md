---
title: Azure Landing Zone for Financial Services
source: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone
retrieved: 2026-06-04
type: raw-article
tags: [azure, landing-zone, financial-services, cloud-architecture, compliance]
---

# Azure Landing Zone for Financial Services — Reference Guide

**Sources:**
- https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone
- https://learn.microsoft.com/en-us/industry/financial-services/fsi-overview
- https://arrt.uk.com/secure-compliant-and-future-ready-microsoft-azure-landing-zones-for-financial-services-integration

---

## Core Definition & Purpose

> An Azure landing zone is the standardized and recommended approach for all organizations utilizing Azure. It provides a consistent way to set up and manage your Azure environment at scale.

- **Goal:** Ensures consistency across your organization by aligning with key requirements for **security, compliance, and operational efficiency**.
- **Foundation:** A well-architected environment built around **8 core design areas** and core design principles.
- **Structure:** Composed of a **Platform landing zone** + one or more **Application landing zones**.

---

## Architecture Overview

- **Nature:** Scalable, modular, and repeatable. Standard configurations and controls are applied to every subscription.
- **Starting Point:** The reference architecture is an "opinionated target architecture" — tailor it to your needs.
- **Supported Topologies:**
  - Hub & Spoke
  - Virtual WAN
  - Management Group Hierarchy Only
- **Resource Organization:**
  - **Platform** management group → Subscriptions hosting shared services
  - **Landing Zones** management group → Subscriptions for workloads (Corp, Online, Local)

---

## Platform vs. Application Landing Zones

| Component | Function | Management |
|---|---|---|
| **Platform Landing Zone** | Shared services (Identity, Connectivity, Management) | Central teams |
| **Application Landing Zone** | Single workload, one per environment | Workload team or shared |

### Application Landing Zone Management Approaches

| Approach | Description |
|---|---|
| **Central team management** | IT fully operates the landing zone |
| **Application team management** | Platform delegates to app team, policies retain governance |
| **Shared management** | Central team manages underlying services; app team manages applications |

---

## Microsoft for Financial Services — Key Differentiators

- **Security:** $1B+ annual R&D investment, multi-layered security
- **Privacy:** Customer owns their data — never used for marketing/advertising
- **Compliance:** 100+ compliance offerings — most extensive among CSPs
- **Reliability:** Built-in resiliency (hardware/rack failure) and recoverability (datacenter/regional failure)

### Compliance & Transparency

- Azure Policy Regulatory Compliance provides built-in initiative definitions
- Microsoft Purview for risk/compliance solutions
- Landing Zones embed security controls automatically
- Control mappings show responsibility (Customer, Microsoft, Shared)

---

## 8 Key Design Areas

1. Azure billing and Microsoft Entra tenant
2. Identity and access management
3. Management group and subscription organization
4. Network topology and connectivity
5. Security
6. Management
7. Governance
8. Platform automation and DevOps

---

## Deployment Options

| Method | Recommendation |
|---|---|
| **IaC Accelerator** | Highly Recommended — Terraform or Bicep |
| **Portal Accelerator** | Alternative (no IaC expertise) |

---

## Financial Services-specific Considerations

- Landing Zones align directly with regulatory expectations
- Backup and DR are part of the landing zone baseline
- Policy-driven governance ensures continuous compliance
- Subscription vending process isolates workloads
- Confidential computing and Managed HSMs for sensitive workloads
