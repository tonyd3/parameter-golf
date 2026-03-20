# Moonshot Research

This note is for the next local moonshot loop after `loop_06`.

Current fixed-`600` local frontier:

- Best quality run:
  - `loop06_exp09_pko32_altcheap8_value`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.92565973`
- Best quality/bytes hybrid:
  - `loop06_exp07_pko32_shared3`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.97217794`
  - `compressed_size_bytes:952069`
- Current dominant themes:
  - `PARTIAL_KEY_OFFSET_DIMS=32`
  - lexical side channels
  - alternating cheap depth
  - shared-depth recurrence for size efficiency

This means the most valuable new moonshots are the ones that plausibly improve:

1. local inductive bias
2. deep/narrow optimization
3. parameter efficiency per byte

while **not** duplicating ideas that already failed:

- naive MTP
- token smear
- low-rank widening
- larger PKO than `32`

## Ranked New Moonshots

### 1. Primer-style depthwise convolution in attention

**Why this is a real moonshot**

Your current best stack is already telling us that stronger local inductive bias matters:

- bigram hash helped a lot
- value-side lexical features helped
- PKO helped a lot

Primer adds a different kind of local bias: a depthwise convolution directly in the Q/K/V pathway.

**Grounding**

- Primer: Searching for Efficient Transformers for Language Modeling  
  https://arxiv.org/abs/2109.08668

Key findings from the paper:

- Primer attributes most of its gains to two simple changes:
  - squared ReLU
  - depthwise convolution after each Q/K/V projection
- The authors report that Primer’s gains increase with scale.
- They report large compute savings for language modeling versus vanilla Transformer.

**Why it fits this repo**

- You already use one of Primer’s two winning ideas indirectly: `relu^2`.
- The other winning idea, depthwise convolution in attention, has not been tried here.
- This is a strong fit for a tiny model because it adds local structure cheaply.

**Why it could significantly change results**

- It attacks the same weakness your successful lexical tricks attack: short-range structure.
- But unlike bigram hash, it changes the attention operator itself.
- That means it can compound with `PKO32` instead of merely adding another side feature.

**What to try**

1. Add causal depthwise `Conv1d` over sequence after Q/K/V projection.
2. Start with very small kernels, like `3` and `5`.
3. Test:
   - `PKO32 + primer_qkv_conv`
   - `PKO32 + altcheap8 + primer_qkv_conv`

**Implementation risk**

- Moderate.
- Cleaner than a full architecture rewrite.

### 2. Hyper-Connections / multi-stream residuals

**Why this is a real moonshot**

Your loops already say depth reuse works:

- shared-depth stacks are strong on bytes
- alternating cheap depth improved quality

Hyper-Connections are a principled replacement for plain residuals in deep/narrow settings.

**Grounding**

- Hyper-Connections  
  https://arxiv.org/abs/2409.19606

Key findings from the paper:

- It explicitly targets the residual bottleneck between gradient vanishing and representation collapse.
- The paper reports significant performance gains over standard residual connections in LLM pretraining.

**Why it fits this repo**

- Your model already has:
  - residual mixing
  - skip weights
  - shared-depth experiments
- So a lightweight hyper-connection variant is conceptually aligned with what is already working.

**Why it could significantly change results**

- If the current frontier is limited by deep signal propagation in narrow models, hyper-connections attack exactly that.
- This is probably the most theory-backed way to go beyond the current `resid_mix + skip_weights` design.

**What to try**

1. Start with `2` residual streams, not full mHC complexity.
2. Wrap only the block input/output mixing first.
3. Test:
   - `PKO32 + 2stream_hc`
   - `PKO32 + altcheap8 + 2stream_hc`
   - `PKO32 + shared3 + 2stream_hc`

**Implementation risk**

- Moderate to high.
- More invasive than Primer, but very plausible.

### 3. Persistent memory vectors inside attention

**Why this is a real moonshot**

This is one of the cleanest parameter-golf ideas in the literature: replace some FFN function with a tiny learned memory that attention can read from.

**Grounding**

- Augmenting Self-attention with Persistent Memory  
  https://arxiv.org/abs/1907.01470

Key findings from the paper:

- The paper augments self-attention with persistent memory vectors.
- It argues these vectors can play a role similar to the feed-forward layer.
- The authors report they can remove the feed-forward layer without degrading Transformer performance on their benchmarks.

**Why it fits this repo**

- Your current best quality recipe still uses `MLP_MULT=1`, already a very small FFN.
- Your current best size-aware recipes suggest that reducing FFN cost can pay off if done carefully.

**Why it could significantly change results**

- If persistent memory can replace some FFN work, that is directly on-theme for parameter golf.
- It may let you:
  - shrink or zero out some MLPs
  - preserve quality better than cheap blocks alone

**What to try**

1. Add a small learned memory bank per layer or globally.
2. Concatenate or append the memory as extra K/V only.
3. Test:
   - `PKO32 + persistent_memory_8`
   - `PKO32 + persistent_memory_16 + cheap_mlp`
   - `PKO32 + shared3 + persistent_memory`

**Implementation risk**

- Moderate.
- The smallest version is relatively easy: fixed learned memory tokens for K/V only.

### 4. Talking-Heads attention

**Why this is a real moonshot**

This is a tiny-parameter intervention that changes how attention heads communicate, which is attractive for a very small model.

**Grounding**

- Talking-Heads Attention  
  https://arxiv.org/abs/2003.02436

Key findings from the paper:

- It adds linear projections across the head dimension before and after softmax.
- The authors report better perplexity and transfer quality with only modest extra parameters and compute.

**Why it fits this repo**

- Your local models are only `4` heads wide.
- That is exactly the regime where head specialization and interaction may be bottlenecked.

**Why it could significantly change results**

- It changes attention expressivity without widening the hidden state much.
- That makes it attractive under a byte budget.
- It also composes naturally with `PKO32`, which is already an attention-side intervention.

**What to try**

1. Add post-softmax head mixing first.
2. If that works, add pre-softmax head mixing too.
3. Test:
   - `PKO32 + talking_heads`
   - `PKO32 + lexical_superstack + talking_heads`

**Implementation risk**

- Moderate.
- Cleaner than hyper-connections.

### 5. GLU / SwiGLU MLP at fixed parameter budget

**Why this is a real moonshot**

Your current best stack still uses the old `relu^2` MLP. That was a good starting point, but GLU-family gates are one of the most replicated Transformer improvements in the literature.

**Grounding**

- GLU Variants Improve Transformer  
  https://arxiv.org/abs/2002.05202

Key findings from the paper:

- GLU-family FFN variants improved quality over ReLU and GELU in Transformer feed-forward layers.

**Why it fits this repo**

- You already know FFN budget matters.
- But your low-rank width experiments failed, which suggests raw width is not the right fix.
- A gated MLP changes the nonlinearity rather than just adding parameters.

**Why it could significantly change results**

- It can improve expressivity without needing much more parameter budget if you adjust hidden width downward to keep bytes comparable.
- This is a better moonshot than “just widen the MLP again.”

**What to try**

1. Implement SwiGLU or GEGLU with width adjusted to keep total params close.
2. Compare against the current `MLP_MULT=1` `relu^2` stack.
3. Test:
   - `PKO32 + swiglu_budget_matched`
   - `PKO32 + altcheap8_value + swiglu_budget_matched`

**Implementation risk**

- Low to moderate.
- Cleaner than many other moonshots.

### 6. DeLighT-style block-wise scaling

**Why this is a real moonshot**

Your results already show that non-uniform depth is promising:

- alternating cheap blocks helped
- shared-depth is the best size-aware family

DeLighT gives a literature-backed way to make the stack deliberately uneven.

**Grounding**

- DeLighT: Deep and Light-weight Transformer  
  https://arxiv.org/abs/2008.00623

Key findings from the paper:

- It reallocates parameters both within blocks and across blocks.
- It reports matching or improving baseline Transformer quality with fewer parameters.
- It explicitly uses block-wise scaling so early blocks are lighter and later blocks are heavier.

**Why it fits this repo**

- Your `altcheap` experiments are a crude version of this idea.
- DeLighT says the idea is not just “skip random MLPs,” but intentionally scale block capacity across depth.

**Why it could significantly change results**

- The current frontier may still be wasting bytes on uniform blocks.
- A designed shallow-to-deep or narrow-to-wide schedule could dominate the current simple cheap-block heuristic.

**What to try**

1. Keep the same total rough parameter budget.
2. Make early blocks cheap and later blocks expensive.
3. Test:
   - `pko32_delight_schedule_4layer`
   - `pko32_delight_schedule_8layer`

**Implementation risk**

- Moderate.
- Requires more block-shape flexibility than the current uniform stack.

### 7. Universal-Transformer-style recurrent depth with shared blocks

**Why this is a real moonshot**

You already have strong evidence that compute reuse matters more than raw stored weights in some parts of the search.

**Grounding**

- Universal Transformers  
  https://arxiv.org/abs/1807.03819
- ALBERT: A Lite BERT  
  https://arxiv.org/abs/1909.11942

Key findings from the papers:

- Universal Transformer argues that recurrent depth adds a helpful inductive bias compared with a fixed stack.
- ALBERT shows cross-layer parameter sharing can drastically reduce parameter count while remaining competitive.

**Why it fits this repo**

- You have already tested naive sharing.
- It was useful for size, but not frontier quality.
- The new idea is not “share more,” but “share with better recurrence structure” or “share with a stronger transition.”

**Why it could significantly change results**

- If the model wants more compute but not more bytes, recurrent depth is one of the few remaining levers.
- This becomes especially interesting if combined with:
  - `PKO32`
  - hyper-connections
  - persistent memory

**What to try**

1. Do not run this as plain `NUM_UNIQUE_BLOCKS=1` again.
2. Combine shared blocks with another strong bias:
   - `PKO32 + shared3 + persistent_memory`
   - `PKO32 + shared3 + hyperconnections`

**Implementation risk**

- Moderate to high.
- Worth doing only if paired with a better recurrence mechanism than the current naive sharing.

## Recommended Loop 08

If we want the next local moonshot loop to be maximally evidence-based, I would do:

1. `PKO32 + primer_qkv_depthwise_conv`
2. `PKO32 + altcheap8_value + primer_qkv_depthwise_conv`
3. `PKO32 + talking_heads`
4. `PKO32 + value_embed + talking_heads`
5. `PKO32 + persistent_memory`
6. `PKO32 + cheap_mlp + persistent_memory`
7. `PKO32 + 2stream_hyperconnections`
8. `PKO32 + altcheap8 + 2stream_hyperconnections`
9. `PKO32 + budget_matched_swiglu`
10. `PKO32 + delight_block_scaling`

## What I Would Build First

If we want highest expected value per implementation hour:

1. Primer-style QKV depthwise conv
2. Talking-heads attention
3. Persistent memory vectors

If we want highest upside regardless of implementation cost:

1. Hyper-connections
2. Primer-style QKV depthwise conv
3. Persistent memory replacing some FFN function

## Sources

- Primer: Searching for Efficient Transformers for Language Modeling  
  https://arxiv.org/abs/2109.08668
- GLU Variants Improve Transformer  
  https://arxiv.org/abs/2002.05202
- Talking-Heads Attention  
  https://arxiv.org/abs/2003.02436
- DeLighT: Deep and Light-weight Transformer  
  https://arxiv.org/abs/2008.00623
- Augmenting Self-attention with Persistent Memory  
  https://arxiv.org/abs/1907.01470
- Universal Transformers  
  https://arxiv.org/abs/1807.03819
- Hyper-Connections  
  https://arxiv.org/abs/2409.19606
- ALBERT: A Lite BERT for Self-supervised Learning of Language Representations  
  https://arxiv.org/abs/1909.11942
