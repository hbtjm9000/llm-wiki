---
title: JBoss/WildFly Server Migration Tool
source: https://github.com/wildfly/wildfly-server-migration
retrieved: 2026-06-04
type: raw-article
tags: [jboss, wildfly, migration, java-ee, middleware]
---

# JBoss/WildFly Server Migration Tool

**Source:** https://github.com/wildfly/wildfly-server-migration
**Documentation:** https://docs.wildfly.org/33/Migration_Guide.html

---

## Overview

The JBoss Server Migration Tool migrates JBoss Application Servers from a **source** server (previous release of WildFly or JBoss EAP) to a **target** server (latest release).

**Capabilities:**
- Migrates server configuration files (`standalone.xml`, `domain.xml`)
- Migrates modules
- Migrates deployments
- Migrates other resources
- Generates HTML/XML migration reports
- Detailed migration logs

---

## Build & Run

### Build from Source
```bash
mvn clean install
```

### Run (Standalone)

**Linux/macOS:**
```bash
./jboss-server-migration.sh -s SOURCE_SERVER_PATH -t TARGET_SERVER_PATH
```

**Windows:**
```cmd
jboss-server-migration.bat -s SOURCE_SERVER_PATH -t TARGET_SERVER_PATH
```

### Example Output
```
---- JBoss Server Migration Tool -------------------------
SOURCE: WildFly Full, version: 30.0.0.Final
TARGET: WildFly Full, version: 40.0.0.Final

Migration tasks:
- Migrating modules
- Migrating standalone server
- Updating subsystem infinispan
- Updating subsystem undertow
- Migrating security realms

Task Summary:
server .............................................. SUCCESS
modules ............................................. SUCCESS
Migration Result: SUCCESS
```

### Artifacts Generated
| File | Description |
|---|---|
| `reports/migration-report.html` | HTML report |
| `reports/migration-report.xml` | XML report |
| `logs/migration.log` | Detailed migration log |

---

## PicketBox Vault → Elytron Credential Store Migration

WildFly 33+ replaces PicketBox Vault with Elytron credential store. The migration tool handles this conversion:

### Create a credential store
```bash
bin/elytron-tool.sh credential-store --create \
  --location=standalone/configuration/credentials.store
```

### Convert existing vault
```bash
bin/elytron-tool.sh vault \
  --enc-dir standalone/configuration/vault \
  --keystore standalone/configuration/vault.keystore \
  --location standalone/configuration/converted.store
```

### Add credential
```bash
bin/elytron-tool.sh credential-store --add=example \
  --location=standalone/configuration/credentials.store
```

---

## Multi-step Migration for Large Jumps

When migrating from WildFly 25+ to versions beyond 31, a multi-step migration is needed:
1. First migrate to WildFly 26
2. Then migrate from WildFly 26 to target version

This is due to the legacy security framework removal in WildFly 31.

---

## Key Takeaways for Banking RFP (JBoss Migration)

1. The official WildFly Server Migration Tool automates config/module/deployment migration
2. Supports Windows→Linux cross-platform migration (Java is write-once-run-anywhere)
3. Generates compliance-grade audit reports (HTML, XML, logs)
4. Elytron credential store migration replaces PicketBox Vault
5. Multi-step migration needed for large version jumps
6. JBoss EAP 8.x / WildFly 34+ are Jakarta EE 10 compatible — modern, supported targets
