---
title: "Sequence to Sequence Learning with Neural Networks"
authors: "Ilya Sutskever, Oriol Vinyals, Quoc V. Le"
venue: "NIPS"
year: 2014
tags: ["seq2seq", "lstm", "machine-translation", "encoder-decoder", "nlp", "foundational"]
paper_url: "https://arxiv.org/pdf/1409.3215"
abstract: |
  Deep Neural Networks (DNNs) are powerful models that have achieved excellent performance on difficult learning tasks. Although DNNs work well whenever large labeled training sets are available, they cannot be used to map sequences to sequences. In this paper, we present a general end-to-end approach to sequence learning that makes minimal assumptions on the sequence structure. Our method uses a multilayered Long Short-Term Memory (LSTM) to map the input sequence to a vector of a fixed dimensionality, and then another deep LSTM to decode the target sequence from the vector. Our main result is that on an English to French translation task from the WMT'14 dataset, the translations produced by the LSTM achieve a BLEU score of 34.8 on the entire test set, where the LSTM's BLEU score was penalized on out-of-vocabulary words. Additionally, the LSTM did not have difficulty on long sentences. For comparison, a phrase-based SMT system achieves a BLEU score of 33.3 on the same dataset. When we used the LSTM to rerank the 1000 hypotheses produced by the aforementioned SMT system, its BLEU score increases to 36.5, which is close to the previous best result on this task. The LSTM also learned sensible phrase and sentence representations that are sensitive to word order and are relatively invariant to the active and the passive voice. Finally, we found that reversing the order of the words in all source sentences (but not target sentences) improved the LSTM's performance markedly, because doing so introduced many short term dependencies between the source and the target sentence which made the optimization problem easier.
notes: |
  **Architecture:**

  The seq2seq model uses a **multi-layered LSTM encoder** to map the input sequence to a fixed-dimensional vector representation, and a **multi-layered LSTM decoder** to generate the target sequence from that vector. The key innovation is using a **multi-layered LSTM to remember structure** - the deep (4-layer) LSTM encoder compresses the entire input sequence into a fixed-size context vector, capturing long-range dependencies and structural information about the input sequence. The deep LSTM decoder then unfolds this representation to generate the output sequence token by token.

  **Key Ideas:**

  1. **Multi-layered LSTM to remember structure**: The 4-layer LSTM encoder is crucial for remembering long-range structural dependencies in the input sequence. Each layer learns progressively more abstract representations - lower layers capture local patterns while higher layers capture global sentence structure. This depth allows the model to "remember" the structure of long sentences (even 30+ words) without degradation, which was a fundamental limitation of shallow RNNs.

  2. **Sequence-to-sequence learning**: A general end-to-end framework for mapping arbitrary input sequences to arbitrary output sequences. The encoder-decoder architecture with a fixed-dimensional vector bottleneck forces the model to learn compressed, meaningful representations.

  3. **Reversing the source sequence**: Reversing the word order in the source sentence (but not target) dramatically improved performance. This creates many short-term dependencies between source and target words early in the sequence, making the optimization problem much easier for SGD. The model learns local alignments first before handling long-distance dependencies.

  4. **LSTM handles long sentences**: Unlike vanilla RNNs, the LSTM's gating mechanism allows it to handle long sentences (30+ words) without significant performance degradation, demonstrating that the multi-layered LSTM effectively "remembers structure" over long distances.

  3. **Reranking SMT hypotheses**: Using the LSTM to rerank 1000-best hypotheses from a phrase-based SMT system boosted BLEU from 34.8 to 36.5, showing the LSTM learns complementary strengths to traditional SMT.

  **Why it matters:**

  This paper introduced the **seq2seq architecture** that became the foundation for modern neural machine translation, text summarization, dialogue systems, and code generation. The encoder-decoder with attention (Bahdanau et al., 2015) and Transformer (Vaswani et al., 2017) architectures both build directly on this foundation. The insight that **multi-layered LSTMs can remember structure** over long sequences was crucial for making sequence-to-sequence learning work in practice.
---