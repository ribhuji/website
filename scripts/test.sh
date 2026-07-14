#!/bin/bash
set -e

HUGO_DIR="ribhu"
PUBLIC_DIR="$HUGO_DIR/public"
ERRORS=0

echo "Building site..."
cd "$HUGO_DIR"
hugo --quiet
cd ..

echo "Checking homepage..."
if ! grep -q "Just How Many USB Devices" "$PUBLIC_DIR/index.html"; then
    echo "FAIL: Blog post 'USB Devices' missing from homepage"
    ERRORS=$((ERRORS + 1))
fi
if ! grep -q "LED Light" "$PUBLIC_DIR/index.html"; then
    echo "FAIL: Blog post 'LED Light' missing from homepage"
    ERRORS=$((ERRORS + 1))
fi
if grep -q "Neural Probabilistic" "$PUBLIC_DIR/index.html"; then
    echo "FAIL: Papers are leaking into homepage posts list"
    ERRORS=$((ERRORS + 1))
fi

echo "Checking about page..."
if ! grep -q "SDE2" "$PUBLIC_DIR/about/index.html"; then
    echo "FAIL: About page missing SDE2 title"
    ERRORS=$((ERRORS + 1))
fi

echo "Checking papers..."
if ! grep -q "Neural Probabilistic" "$PUBLIC_DIR/papers/a-neural-probabilistic-language-model/index.html"; then
    echo "FAIL: Bengio paper missing"
    ERRORS=$((ERRORS + 1))
fi
if ! grep -q "LLM Inference" "$PUBLIC_DIR/papers/llm-inference-at-the-edge/index.html"; then
    echo "FAIL: LLM Inference paper missing"
    ERRORS=$((ERRORS + 1))
fi

if [ "$ERRORS" -eq 0 ]; then
    echo "All checks passed."
else
    echo "$ERRORS check(s) failed."
    exit 1
fi
