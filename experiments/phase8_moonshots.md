# Phase 8: Five Moonshots

The optimization-only regime has likely reached diminishing returns. Phase 8 focuses on structural changes that could create step-function gains in quality-per-parameter or compression-per-parameter.

These are not intended as small ablations. Each experiment family should test a genuinely different modeling strategy on the PyTorch/CUDA path in [`train_gpt.py`](/workspace/parameter-golf/train_gpt.py).

## 81. Residual n-gram prior logits

### idea

Add an explicit learned local prior that predicts logits directly from recent token history, then train the transformer to model only the residual.

Target form:

```text
final_logits = ngram_prior_logits + transformer_residual_logits
```

### why this is a moonshot

- Language compression is dominated by common short-range patterns.
- A cheap explicit prior can offload predictable local structure from the transformer.
- This could improve both sample efficiency and byte efficiency if the prior is compact.

### concrete implementation target

Add to [`train_gpt.py`](/workspace/parameter-golf/train_gpt.py):

- `BIGRAM_LOGIT_VOCAB`
- optional `TRIGRAM_LOGIT_VOCAB`
- a hashed lookup that maps recent token context to a learned logit table or low-rank logit basis
- a mixing scalar or vector:
  - `NGRAM_PRIOR_SCALE`
  - optional learned per-token blending

Start with:

- hashed bigram prior only
- no extra control flow
- residual transformer path unchanged except for summing prior logits before loss

### first runnable variant

- `BIGRAM_LOGIT_VOCAB=4096`
- keep the current best remote recipe close to experiment `43`
- compare against:
  - no prior
  - bigram prior only
  - bigram prior + existing `BIGRAM_HASH_VOCAB`

### success criterion

Beat experiment `43` by a meaningful margin, not just `0.002`. This family is only interesting if it creates a visibly different quality curve or compressibility profile.

## 82. Shared/recurrent block stack

### idea

Replace the “one unique block per layer” assumption with a small number of shared blocks reused across many logical layers.

### why this is a moonshot

- Parameter golf rewards compute-heavy, weight-light designs.
- Recurrent reuse may buy depth without paying full parameter cost.
- The current code already has a clean `Block` abstraction, so the PyTorch path is a reasonable place to support reuse.

### concrete implementation target

Add to [`train_gpt.py`](/workspace/parameter-golf/train_gpt.py):

- `NUM_UNIQUE_BLOCKS`
- a mapping from logical layer index to shared block index
- optional per-logical-layer modulation:
  - learned residual scale
  - learned step embedding
  - learned gate or FiLM-style bias

Start with:

- `NUM_LAYERS=12`
- `NUM_UNIQUE_BLOCKS=3`
- repeated block schedule `0,1,2,0,1,2,...`
- separate per-layer scale parameters even when weights are shared

### first runnable variant

- shared `3-of-12` stack
- shared `2-of-12` stack
- compare to the normal `9x512` baseline at the same wallclock

### success criterion

Show either:

- better final `val_bpb` at similar artifact size, or
- similar `val_bpb` at substantially lower int8+zlib bytes

## 83. Lexical feature super-stack

### idea

Make the front end much more lexical and structured instead of relying on a single token embedding plus vanilla attention.

### why this is a moonshot

- The bigram embedding result suggests lexical structure is under-modeled in the current stack.
- Small models often waste too much capacity rediscovering simple token transition statistics.

### concrete implementation target

Extend [`train_gpt.py`](/workspace/parameter-golf/train_gpt.py) with:

- existing `BIGRAM_HASH_VOCAB` kept as one feature
- `USE_VALUE_EMBED`
- `USE_SECOND_INPUT_EMBED`
- optional hashed token-feature embeddings:
  - punctuation class
  - whitespace / word-start class
  - digit / alpha class

Fuse features by:

- summation into the residual stream, or
- separate value-side injection plus input-side lexical fusion

### first runnable variant

- token embedding
- bigram hash embedding
- separate value embedding
- compare:
  - token only
  - token + bigram
  - token + bigram + value path

### success criterion

Demonstrate that richer lexical structure compounds on the remote path, not just on the local MLX proxy.

## 84. Structured output head

### idea

Replace the flat output projection with a more structured head that is either more expressive per byte or more compressible.

### why this is a moonshot

- The output head is one of the most important and expensive parts of the model.
- A better head can improve both modeling quality and submission artifact efficiency.

### concrete implementation target

Add one of these to [`train_gpt.py`](/workspace/parameter-golf/train_gpt.py):

- low-rank residual head:
  - `logits = tied_logits + A(Bx)`
- clustered head:
  - predict coarse token bucket first, then residual within bucket
- basis head:
  - predict coefficients over a learned logit basis instead of a full dense head

Start with the least invasive version:

- tied head plus learned low-rank residual
- environment knob: `LM_HEAD_DELTA_RANK`

### first runnable variant

- `LM_HEAD_DELTA_RANK=32`
- `LM_HEAD_DELTA_RANK=64`
- compare against:
  - tied head
  - fully untied head

### success criterion

Find a head variant that closes most of the untied-head quality gain without paying the full untied-head byte cost.

## 85. Hybrid attention + recurrence mixer

### idea

Stop assuming every layer needs full attention plus MLP. Replace part of the stack with a cheaper temporal mixer that still carries sequence state.

### why this is a moonshot

- Full attention in every layer may be an inefficient use of parameters for this regime.
- A hybrid stack could preserve local and medium-range mixing while freeing bytes for more useful modules elsewhere.

### concrete implementation target

Add an alternate block type in [`train_gpt.py`](/workspace/parameter-golf/train_gpt.py):

- gated EMA / RWKV-like recurrence, or
- depthwise causal convolution + gate, or
- simple linear recurrence mixer

Then allow schedules such as:

- `ATTN, REC, ATTN, REC, ...`
- first half recurrent, second half attention

Suggested env knobs:

- `RECURRENT_BLOCK_EVERY`
- `RECURRENT_STATE_DIM`
- `RECURRENT_MIXER=ema|conv`

### first runnable variant

- replace every other block with a gated EMA-style mixer
- keep embedding, norms, and output head unchanged
- compare against the normal stack at equal wallclock

### success criterion

Show that the hybrid model is competitive enough to justify exploring a new model family rather than just tuning the old one.

## build order

The order below is the most pragmatic sequence:

1. `81` residual n-gram prior logits
2. `84` structured output head
3. `82` shared/recurrent block stack
4. `83` lexical feature super-stack
5. `85` hybrid attention + recurrence mixer

## selection rule

Do not branch into many knobs inside a family until the first variant shows a real effect. If the first clean version is flat or negative, move on quickly.
