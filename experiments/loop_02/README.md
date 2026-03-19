# Loop 02

This is the active local MLX self-improvement loop.

Anchor evidence:

- strongest recorded local proxy result from the previous phase:
  - `loop02_exp10_batch16384`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.12161593`
  - `serialized_model_int8_zlib:1044469 bytes`
- recipe lineage:
  - based on `exp36_bigram2048_seq512_clip05_untied_300`
  - local proxy uses `VAL_MAX_TOKENS=1048576`
  - local trainer is `train_gpt_mlx.py`

This loop upgrades local runs to `ITERATIONS=600` and keeps the experiments comparable by fixing:

- `VAL_MAX_TOKENS=1048576`
- `TRAIN_SEQ_LEN=512`
- `MODEL_DIM=128`
- `NUM_LAYERS=4`
- `NUM_HEADS=4`
- `NUM_KV_HEADS=2`
- `MLP_MULT=1`
- `TRAIN_BATCH_TOKENS=8192` unless explicitly varied

## Ranked Hypotheses

1. `01_anchor_600`
   The current best local stack still has headroom at `600` steps and should beat the best `300`-step result.
2. `02_warmdown_120`
   A longer cooldown should help once local runs are extended to `600` steps.
3. `03_bigram_4096`
   The bigram hash feature is still underprovisioned at `2048` buckets and should improve with `4096`.
4. `04_retie_embeddings`
   Untying helped at `300` steps, but at `600` steps tied embeddings may regularize better and compress more cleanly.
5. `05_no_clip`
   Weight clipping may have become unnecessary once the model trains longer; removing it will test whether it is still carrying its weight.
6. `06_no_bigram`
   Bigram hash is likely one of the main local wins; removing it will measure how much of the current stack depends on it.
7. `07_value_embed_best`
   Value embeddings were positive on their own and may compound with the best local stack.
8. `08_second_input_best`
   A second input embedding path was locally positive and may still compound at `600` steps.
9. `09_batch_4096`
   A smaller local token batch may improve learning efficiency per update over a longer run.
10. `10_batch_16384`
   A larger local token batch may improve stability enough to beat the current anchor.

## Comparison Target

Unless otherwise stated, every experiment in this loop compares against:

- `loop02_exp10_batch16384`
- `final_int8_zlib_roundtrip_exact val_bpb:2.12161593`
- `serialized_model_int8_zlib:1044469 bytes`
