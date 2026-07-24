---
title: "Billion-scale similarity search with GPUs"
authors: "Jeff Johnson, Matthijs Douze, Hervé Jégou"
venue: "IEEE Transactions on Big Data"
year: 2017
tags: ["gpu", "similarity-search", "nearest-neighbor", "faiss", "high-performance-computing"]
paper_url: "https://arxiv.org/pdf/1702.08734"
abstract: |
  Similarity search finds application in specialized database systems handling complex data such as images or videos, which are typically represented by high-dimensional features and require specific indexing structures. This paper tackles the problem of better utilizing GPUs for this task. While GPUs excel at data-parallel tasks, prior approaches are bottlenecked by algorithms that expose less parallelism, such as k-min selection, or make poor use of the memory hierarchy. We propose a design for k-selection that operates at up to 55% of theoretical peak performance, enabling a nearest neighbor implementation that is 8.5x faster than prior GPU state of the art. We apply it in different similarity search scenarios, by proposing optimized design for brute-force, approximate and compressed-domain search based on product quantization. In all these setups, we outperform the state of the art by large margins. Our implementation enables the construction of a high accuracy k-NN graph on 95 million images from the Yfcc100M dataset in 35 minutes, and of a graph connecting 1 billion vectors in less than 12 hours on 4 Maxwell Titan X GPUs.
notes: |
  **Core Idea:**

  The paper tackles billion-scale nearest neighbor search on GPUs. The key innovation is **WarpSelect**, a k-selection algorithm that operates entirely in GPU registers at ~55% of theoretical peak performance, achieving 8.5x speedup over prior GPU state-of-the-art. The system uses **L2 (Euclidean) distance** for similarity measurement between vectors.

  **WarpSelect Architecture:**

  The algorithm maintains two data structures in registers:
  1. **Thread Queue** (size t): Each thread has a small private buffer (t ≈ 2-8 elements) for streaming input. Unsorted, zero inter-thread communication.
  2. **Warp Queue** (size k): A sorted array distributed across all 32 warp lanes using lane-stride register layout. Holds the current global top-k smallest distances.

  Flow: Stream in distances → Fast-path drop if ≥ threshold → Fill thread queue → Sort via bitonic network → Merge into warp queue → Keep only top-k → Update threshold.

  **Key Technical Contributions:**

  1. **In-register data structure**: Instead of using shared memory or global memory, the entire top-k state lives in scalar registers distributed across the warp. Each lane j holds elements {a_j, a_{32+j}, a_{64+j}, ...}. This leverages register file bandwidth (10-100s TB/s) vs shared memory.

  2. **Cross-warp communication via shuffle**: When threads need to compare data, they use hardware `__shfl_xor_sync` (butterfly permutations) for direct lane-to-lane register transfer over crossbar switches—no shared memory writes.

  3. **Odd-size bitonic merging**: Standard bitonic networks assume power-of-2 sizes, but k is arbitrary (e.g., k=100). The paper extends merging to handle arbitrary sizes with an inverted first comparison stage followed by recursive sub-merges with implicit padding.

  4. **Single-pass streaming**: The algorithm processes elements in a single pass through the data, unlike multi-pass radix selection or heap-based approaches that require repeated global memory reads/writes.

  **Why It Beats Traditional Approaches:**

  - **Memory tier**: 100% register file vs global/shared memory (10-100x bandwidth advantage)
  - **Branching**: Fixed instruction sequences (sorting networks) vs heavy warp divergence in heap selection
  - **Kernel fusion**: Can be fused directly into GEMM/PQ lookup inner loops vs requiring separate kernel launches

  **Performance:**

  - 95M images k-NN graph: 35 minutes on 4 Maxwell Titan X GPUs
  - 1 billion vectors graph: <12 hours on 4 Maxwell Titan X GPUs

  **Why it matters:**

  This work made billion-scale similarity search practical on GPUs and became foundational for FAISS (Facebook AI Similarity Search), one of the most widely used vector search libraries. The register-based WarpSelect design demonstrated that careful attention to GPU memory hierarchy can yield order-of-magnitude improvements.
---