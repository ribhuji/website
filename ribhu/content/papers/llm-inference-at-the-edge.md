---
title: "LLM Inference at the Edge: Mobile, NPU, and GPU Performance Efficiency Trade-offs Under Sustained Load"
authors: "Pranay Tummalapalli, Sahil Arayakandy, Ritam Pal, Kautuk Kundan"
venue: "arXiv 2026"
year: 2026
tags: ["llm", "edge-deployment", "mobile", "npu", "gpu", "inference"]
paper_url: "https://arxiv.org/pdf/2603.23640"
abstract: |
  Deploying large language models on-device for always-on personal agents demands sustained inference from hardware tightly constrained in power, thermal envelope, and memory. We benchmark Qwen 2.5 1.5B (4-bit quantised) across four platforms: a Raspberry Pi 5 with Hailo-10H NPU, a Samsung Galaxy S24 Ultra, an iPhone 16 Pro, and a laptop NVIDIA RTX 4050 GPU. Using a fixed 258-token prompt over 20 warm-condition iterations per device, we measure throughput, latency, power, and thermal behaviour. For mobile platforms, thermal management supersedes peak compute as the primary constraint: the iPhone 16 Pro loses nearly half its throughput within two iterations, and the S24 Ultra suffers a hard OS-enforced GPU frequency floor that terminates inference entirely. On dedicated hardware, distinct constraints dominate: the RTX 4050 is bounded by its battery power ceiling, while the Hailo-10H is limited by on-module memory bandwidth. The RTX 4050 sustains 131.7 tok/s at 34.1 W; the Hailo-10H sustains 6.9 tok/s at under 2 W with near-zero variance, matching the RTX 4050 in energy proportionality at 19x lower throughput.
notes: |
  **Observations & Critique:**
  
  1. **Inconsistent architectures across platforms**: Samsung S24 Ultra (Snapdragon 8 Gen 3, ARM) and Raspberry Pi 5 (BCM2712, ARM) are ARM-based, while the laptop used an x86 GPU (RTX 4050). An ARM-based laptop like the Qualcomm Snapdragon X Elite would have provided a fairer cross-platform comparison.
  
  2. **Software stack variability**: Each device ran a different OS (iOS, Android, Linux, Windows/Linux). Using a uniform OS like Alpine Linux or postmarketOS across all devices would eliminate software-induced variability and isolate hardware performance differences.
  
  3. **Limited prompt diversity**: A single 258-token prompt was used across all devices. More prompts covering different tasks (coding, reasoning, conversation) would strengthen the benchmark. Consider using standardized tools like llm-bench that already include diverse prompt sets.
  
  4. **Missing Apple Silicon comparison**: MacBook with M-series chips (M1/M2/M3/M4) would be a valuable addition for edge inference benchmarks, given their strong ML performance and unified memory architecture.
---