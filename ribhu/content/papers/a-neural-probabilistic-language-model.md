---
title: "A Neural Probabilistic Language Model"
authors: "Yoshua Bengio, Réjean Ducharme, Pascal Vincent, Christian Jauvin"
venue: "JMLR"
year: 2003
tags: ["word-embeddings", "neural-networks", "language-modeling", "nlp", "foundational"]
paper_url: "https://www.jmlr.org/papers/volume3/bengio03a/bengio03a.pdf"
abstract: |
  A goal of statistical language modeling is to learn the joint probability function of sequences of words in a language. This is intrinsically difficult because of the curse of dimensionality: a word sequence on which the model will be tested is likely to be different from all the word sequences seen during training. Traditional but very successful approaches based on n-grams obtain generalization by concatenating very short overlapping sequences seen in the training set. We propose to fight the curse of dimensionality by learning a distributed representation for words which allows each training sentence to inform the model about an exponential number of semantically neighboring sentences. The model learns simultaneously (1) a distributed representation for each word along with (2) the probability function for word sequences, expressed in terms of these representations.
notes: |
  **Architecture:**

  The model takes a sequence of previous words, maps each to a dense vector (embedding) via a shared lookup table, concatenates these vectors, passes them through a hidden layer with a tanh activation, and outputs a probability distribution over the next word using softmax. The key insight is that words with similar meanings end up near each other in the embedding space.

  ![Neural Network Architecture](/images/bengio_nplm_architecture.png)

  **Key Ideas:**

  1. **Word embeddings as distributed representations**: Each word is mapped to a vector in a continuous space (e.g., 30 dimensions). Words that are semantically similar (like "running" and "walking", or "cat" and "dog") cluster together in this space, while unrelated words are far apart. This is the precursor to modern word embeddings like Word2Vec and GloVe.

  2. **Maximizing log-likelihood**: The model is trained by maximizing the log-likelihood of the training data, similar to how trigram or bigram models work. But instead of counting co-occurrences, the neural network learns a smooth probability function that generalizes better to unseen sequences.

  3. **Fighting the curse of dimensionality**: N-gram models suffer because the number of possible word combinations grows exponentially. By learning continuous representations, the model can generalize from a single observed sequence to all sequences involving similar words.

  **Why it matters:**

  This paper laid the groundwork for virtually all modern NLP. The idea that words can be represented as dense vectors in a learned space became the foundation for Word2Vec, GloVe, and eventually the contextual embeddings used in Transformers and large language models today. The architecture itself is simple, but the principle of learning word representations jointly with the task was revolutionary.
---
