# Experiment 26: Port Bigram Hash Embedding

## hypothesis

Injecting a cheap hashed bigram feature will help the small model capture local token transitions without paying for a large dense embedding table.

## changes

- Add a hashed bigram embedding path based on adjacent tokens
- Keep the main tokenizer and model shape fixed
- Start from the current best tied local stack from experiment 21:
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - comparison point: `val_bpb 2.56879698`, `729099 bytes`
- First local port uses `BIGRAM_HASH_VOCAB=2048`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports a hashed bigram embedding path through `BIGRAM_HASH_VOCAB`
- `exp26_bigram2048`
  - `BIGRAM_HASH_VOCAB=2048`
  - `model_params:723216`
  - `final_int8_zlib_roundtrip_exact val_loss:4.12486124`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.47139713`
  - `serialized_model_int8_zlib:958431 bytes`

## analysis and conclusion

This was a strong positive result immediately. The bigram-hash path improved the tied 100-step stack by a large margin, which strongly suggests the small model benefits from an explicit cheap local transition feature.

Conclusion: this is the best new `modded-nanogpt` port so far and should move near the top of the queue for compounding with the untied and longer-run stacks.
