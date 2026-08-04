---
title: Twingate
created: 2026-05-29
updated: 2026-05-29
type: entity
tags: [zero-trust, remote-access, network, security, twingate]
sources:
  - twingate.com/docs
  - twingate.com/docs/homelab-personal-use-case
  - readthemanual.co.uk/secure-your-homelab-2025
---

# Twingate

Zero-trust remote access solution — replaces traditional VPNs and port forwarding.
Twingate creates outbound-only connectors on your network that establish encrypted
tunnels to Twingate Cloud. Users authenticate per-service (not per-network) via
the Twingate Client.

## Why Twingate Over VPN

"VPN is dead" — the old model was "join the network, access everything." Twingate's
model is "authenticate to each service individually." Zero-trust replaces network-level
trust with identity-based, device-based, and context-based authorization for every
request, every time.

## Architecture

```
User Device (Twingate Client)
  → Twingate Cloud (control plane)
    → Twingate Connector (Docker on your network — outbound only)
      → Your Services (SSH, web apps, databases, APIs)
```

ALL traffic encrypted via WireGuard. NO open inbound firewall ports.

## Twingate vs Cloudflare Tunnel

| Aspect | Twingate | Cloudflare Tunnel |
|--------|----------|-------------------|
| Protocols | All (SSH, RDP, DB, HTTP, TCP, UDP) | HTTP(S) only |
| Access method | Native client app | Browser-based |
| Client needed | Yes (desktop/mobile) | No (browser-only) |
| Best for | Mixed protocol workloads (homelab) | Public web apps only |
| Free tier | 5 users, unlimited devices | 50 users |
| Architecture | Outbound connector + client | cloudflared sidecar |

They are NOT competitive for homelab use. Twingate replaces the entire
"VPN + exposed web apps" model. Cloudflare Tunnel is a web-proxy workaround
for exposing HTTP services.

## Free Tier

- 5 users
- Unlimited devices
- 10 connectors
- No credit card required

## Setup on k3s

1. Deploy Twingate Connector as a Deployment (Docker container)
2. Authenticate connector with enrollment token from Twingate Console
3. Define Resources (SSH:22, Crumbs:8090, Grafana:3000, etc.)
4. Install Twingate Client on admin devices
5. Test access — no more port forwarding

## Related Pages
- homelab-infrastructure-stack
- Authentik
- SeaweedFS
