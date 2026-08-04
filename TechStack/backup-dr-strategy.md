---
title: Backup Dr Strategy
created: 2026-06-30
updated: 2026-06-30
type: entity
tags: [uncategorized]
---
# Workspace Backup & Disaster Recovery Strategy

**Last updated:** 2026-05-17
**Status:** Strategy document — implementation pending

---

## Problem Space

The Agentic workspace has multiple systems of record that require backup:

| System | Data Type | Size (est.) | Criticality |
|--------|-----------|-------------|-------------|
| Crumbs | SQLite + files | <100MB | High — operational kanban |
| Forgejo | SQLite + git repos | <1GB | High — source of truth for code |
| Hermes | config.yaml, auth.json, .env | <1MB | Critical — agent identity |
| PostgreSQL (Langfuse) | Full database | <500MB | High — observability traces |
| NATS JetStream | Stream data | Variable | Medium — event history |
| Caddy | Caddyfile + certs | <1MB | High — TLS termination |
| FocalBoard (fallback) | Docker volume SQLite | <100MB | Low — fallback only |

Three architectural dimensions determine the right toolset:

1. **Snapshot technology** — atomic, instant captures of data state
2. **Continuous Data Protection (CDP)** — real-time or near-real-time replication
3. **Erasure coding** — data redundancy across storage nodes/disks

---

## Tool Landscape

### Snapshot-Native Tools

| Tool | Mechanism | Granularity | Overhead | Requires |
|------|-----------|-------------|----------|----------|
| **ZFS snapshots** | Kernel-level CoW snapshots | Dataset | Near-zero | ZFS filesystem |
| **btrfs snapshots** | Kernel-level CoW snapshots | Subvolume | Low | btrfs filesystem |
| **LVM snapshots** | Block-level COW | Logical volume | Degrades on writes | LVM |
| **Kopia** | Policy-based file snapshots | Directory | Moderate | — |
| **Restic** | Manual/orchestrated snapshots | Directory | Moderate | — |

### Continuous Data Protection (CDP)

| Tool | Mechanism | Scope | RPO | RTO |
|------|-----------|-------|-----|-----|
| **Litestream** | WAL tail → S3 streaming | SQLite only | <1s | Minutes |
| **LiteFS** | FUSE + WAL replication | SQLite only | <1s | Seconds (with replica) |
| **pg_receivewal** | Continuous WAL archiving | PostgreSQL only | <1s | Minutes |
| **pg_backrest** | Periodic + WAL archiving | PostgreSQL only | Configurable | Configurable |

### Erasure Coding at Storage Layer

| Tool | EC Method | License (2026) | Notes |
|------|-----------|----------------|-------|
| **ZFS RAID-Z** | Variable-width Reed-Solomon | CDDL | Mature, block-level |
| **MinIO** | Per-object Reed-Solomon | AGPL v3 | CE effectively dead — features stripped |
| **Garage** | Configurable replication | AGPL v3 | Actively maintained, lightweight |
| **SeaweedFS** | Erasure-coded volumes | MIT | Lightweight, Go, S3-compatible |

---

## Recommended Architecture: Two-Phase Strategy

### Phase 1: Interim — Restic + Litestream (Now)

Until the offsite target and ZFS root container are ready, use a simple interim approach:

```
systemd timer (daily 02:00)
  └── backup.sh
        ├── 1. sqlite3 .backup /tmp/crumbs-db.sqlite3
        ├── 2. pg_dumpall > /tmp/langfuse-pg.sql
        ├── 3. restic backup /tmp/crumbs-db.sqlite3 /tmp/langfuse-pg.sql \
        │         ~/.hermes/config.yaml ~/.hermes/auth.json \
        │         ~/.paradigm/caddy/ ~/.config/systemd/user/ \
        │         ~/lab/crumbs/files/
        ├── 4. restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 12 --prune
        └── 5. restic check
```

**Targets:** Local USB disk + Backblaze B2 (when configured)
**Restic retention:** 7 daily, 4 weekly, 12 monthly
**Litestream** runs continuously alongside, tailing crumbs.db WAL → local + cloud S3
**Estimated B2 cost at current scale:** <$0.50/month

**Weaknesses of Phase 1:**
- No filesystem-level snapshots (backup is file-copy based)
- CDP only for SQLite (via Litestream) — other data has ~24h RPO
- No erasure coding — single-disk failure on backup target loses everything
- Manual restore process (scripts exist but not tested as DR drill)

### Phase 2: Root Container with ZFS (Target)

The root container (super-container for all four agent types) uses ZFS as its backing filesystem. This solves all three dimensions at the infrastructure layer:

```
┌─────────────────────────────────────────────────┐
│              Root Container (super-container)     │
│  ┌───────────────────────────────────────────┐   │
│  │  ZFS Pool (single disk or mirror)         │   │
│  │                                           │   │
│  │  ├── zpool/crumbs/       ← dataset       │   │
│  │  ├── zpool/forgejo/      ← dataset       │   │
│  │  ├── zpool/hermes/       ← dataset       │   │
│  │  ├── zpool/pg/           ← dataset       │   │
│  │  └── zpool/nats/         ← dataset       │   │
│  │                                           │   │
│  │  Sanoid: snapshots every 15min → retain  │   │
│  │           hourly/daily/weekly/monthly     │   │
│  │                                           │   │
│  │  Syncoid: push snapshots to:             │   │
│  │    ├── Local backup disk (USB/eSATA)     │   │
│  │    └── Offsite ZFS target (TBD)           │   │
│  └───────────────────────────────────────────┘   │
│                                                   │
│  Agents running on ZFS:                           │
│  ├── Riki (CoS)                                   │
│  ├── Nanobot (CRM)                                │
│  ├── OpenCode (Dev)                               │
│  └── Pi (Custom harness)                          │
└─────────────────────────────────────────────────┘
```

**What ZFS provides:**

| Capability | How ZFS Delivers | Equivalent in Phase 1 |
|------------|------------------|----------------------|
| **Snapshots** | Instant, atomic, near-zero cost. Roll back a failed upgrade in seconds. | Restic — 24h+ granularity |
| **CDP-like** | Sanoid snapshots every 15min. Can be as frequent as 1min. | Litestream only (SQLite) |
| **Data integrity** | Checksum all data + metadata. Silent corruption detection on every read. | None — trust the filesystem |
| **RAID-Z (EC-like)** | Variable-width parity across drives. Survives 1-3 disk failures. | Single disk — no redundancy |
| **Replication** | Syncoid — incremental `zfs send` to remote target. Encrypted, resumeable. | Restic to B2 (file-based) |
| **Compression** | Built-in lz4/zstd — often faster than uncompressed. | None |

**Offsite target options (for Syncoid replication):**

| Target | Cost | Notes |
|--------|------|-------|
| rsync.net | ~$0.02/GB/mo | Native ZFS support — `zfs send` directly. 7-day free trial. |
| Backblaze B2 | ~$0.006/GB/mo | Cheapest. Syncoid → rclone to B2, or Restic on the ZFS host. |
| Second homelab server | Free (hardware) | Best RTO. Full ZFS replication. Requires second box. |
| Cloud VPS + ZFS | ~$10-20/mo | DigitalOcean / Linode with block storage. Run Syncoid to remote ZFS. |

**Cost estimate at 5GB workspace data:**
- B2: ~$0.03/month
- rsync.net: ~$0.10/month
- VPS: ~$10-20/month (includes compute)

---

## Tool Comparison Summary

| Feature | Restic | Kopia | ZFS+Sanoid+Syncoid | Litestream |
|---------|--------|-------|-------------------|------------|
| License | BSD-2 | Apache 2.0 | CDDL | AGPL v3 |
| Encryption | AES-256 (built-in) | AES-256 (built-in) | None (use ZFS encryption) | TLS (in-transit) |
| Deduplication | Yes (fixed blocks) | Yes (variable blocks) | No (CoW handles it) | No |
| Snapshots | Periodic (orchestrated) | Policy-based | Instant, atomic | Continuous (WAL) |
| CDP | No | No | Near (15min windows) | Yes (<1s RPO) |
| Erasure coding | No | No | RAID-Z | No |
| Cloud targets | S3, B2, SFTP | S3, B2, GCS, Azure | ZFS remote (syncoid) | S3-compatible |
| Restore speed | File-based (slow for many small files) | File-based | `zfs rollback` (instant) | S3 download + replay |
| Complexity | Low | Low-Medium | High (requires ZFS) | Low |

---

## Decision Flow

```
Is ZFS available?
├── YES → Use ZFS + Sanoid + Syncoid as primary backup layer
│         Add Restic on top for encrypted offsite to B2
│         Add Litestream for CDP on critical SQLite databases
│
└── NO  → Is this interim (pre-root-container)?
          ├── YES → Phase 1: Restic + Litestream
          │         - Restic to local USB + B2 (daily)
          │         - Litestream for crumbs.db (continuous)
          │         - pg_dump for PostgreSQL (daily)
          │
          └── NO  → Install ZFS and migrate data
```

---

## Related

- [Crumbs Operations Manual](../crumbs/docs/operations/deployment.md) — Service-level backup procedures
- [Root Container Architecture](./root-container.md) — Super-container design with ZFS integration
- [Offsite Target Research](./backup-offsite-targets.md) — Evaluation of rsync.net, B2, VPS options
