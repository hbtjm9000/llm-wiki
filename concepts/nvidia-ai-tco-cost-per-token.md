---
title: NVIDIA AI TCO Cost Per Token
type: concept
created: 2026-04-19
source: blogs.nvidia.com
tags:
  - ai-infrastructure
  - inference
  - tco
  - nvidia
---

# NVIDIA AI TCO: Cost Per Token Analysis

## Key Insight

**Cost per token = the metric that matters** — not FLOPS per dollar

## Key Equation

```
Cost per million tokens = [cost per GPU per hour / (tokens per GPU per second x 3600)] x 1M
```

## The "Inference Iceberg"

- **Above surface** (visible): cost per GPU hour, peak FLOPS, HBM capacity
- **Below surface** (what matters): tokens per watt, token output per second, codesign

## Benchmark: Blackwell vs Hopper

| Metric | Hopper (HGX H200) | Blackwell (GB300 NVL72) | Relative |
|-------|------------------|----------------------|---------|
| Cost/GPU/hr | $1.41 | $2.65 | 2x |
| PFLOPS/$ | 2.8 | 5.6 | 2x |
| Tokens/sec/GPU | 90 | 6,000 | **65x** |
| Tokens/sec/MW | 54K | 2.8M | **50x** |
| Cost per 1M tokens | $4.20 | $0.12 | **35x lower** |

## Key Factors That Drive Down Token Cost

1. **Extreme codesign** - compute, networking, memory, storage, software
2. **FP4 precision** support
3. **Speculative decoding** / multi-token prediction
4. **KV-aware routing**, disaggregated serving
5. **Tokens per watt** efficiency

## Source

- [NVIDIA Blog](https://blogs.nvidia.com/blog/lowest-token-cost-ai-factories/)
- Benchmark data: SemiAnalysis InferenceX v2