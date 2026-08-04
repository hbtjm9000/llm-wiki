---
title: JBoss/WildFly Server Migration Tool
created: 2026-06-04
updated: 2026-06-04
type: concept
tags: [jboss, wildfly, migration, java-ee, middleware, banking]
sources:
  - raw/articles/wildfly-server-migration-tool.md
---

# JBoss/WildFly Server Migration Tool

## Overview

The official **JBoss Server Migration Tool** (wildfly/wildfly-server-migration on GitHub) automates migration of JBoss EAP and WildFly application servers between versions — including across OS boundaries (Windows → Linux). For a banking platform migrating from Windows Server to Ubuntu, this tool is the primary migration automation artifact.

## What It Migrates

| Artifact | How |
|---|---|
| `standalone.xml` / `domain.xml` | Config files parsed and rewritten for target version |
| Modules | Migrated and updated |
| Deployments | Existing WAR/EAR files carried over |
| Security realms | PicketBox vault → Elytron credential store |
| Subsystems | infinispan, undertow, datasources, etc. |

## Multi-Step Migration for Large Version Jumps

```
WildFly 25+ ──→ WildFly 26 ──→ WildFly 34+
    (legacy security)   (interim)   (target)
```

This is required when jumping across the legacy security framework removal boundary (WildFly 31).

## PicketBox → Elytron Migration

The most significant config change. The migration tool and `elytron-tool.sh` handle:

```
PicketBox Vault ──→ Credential Store
                         ├── Secret key for encrypted expressions
                         └── Alias-based credential lookup
```

### Key commands for the migration playbook:
```bash
# Create credential store
elytron-tool.sh credential-store --create \
  --location=standalone/configuration/credentials.store

# Convert existing vault
elytron-tool.sh vault \
  --enc-dir standalone/configuration/vault \
  --keystore standalone/configuration/vault.keystore \
  --location standalone/configuration/converted.store
```

## Why It Matters for Banking

1. **Compliance-grade audit trail** — Tool generates HTML report, XML report, and detailed migration log (auditable evidence)
2. **Zero-code migration path** — Java EE apps on JBoss require zero code changes for OS migration (Java is write-once-run-anywhere)
3. **Risk reduction** — Automated migration eliminates manual config drift between environments
4. **Rollback support** — Tool reports enable verification before cutover

## Related

- Online Banking Platform Upgrade — RFP Blueprint — Architecture document using this tool
- Azure Landing Zone for Regulated Industries — Target infrastructure for migrated JBoss
