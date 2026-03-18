# Experiment 21: Combine `seq512` And `clip0.5`

## hypothesis

The two strongest local improvements so far, shorter sequence length and moderate post-step clipping, may compound rather than overlap.

## changes

- Start from the best non-shared 100-step local recipe
- Combine:
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
- Keep the 1M-token validation proxy fixed

## experiment results

- Comparison points
  - experiment 12 `TRAIN_SEQ_LEN=512`: `val_bpb 2.59355021`
  - experiment 17 `POST_STEP_WEIGHT_CLIP=0.5`: `val_bpb 2.58737833`
- `exp21_seq512_clip05`
  - `final_int8_zlib_roundtrip_exact val_loss:4.28742552`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.56879698`
  - `serialized_model_int8_zlib:729099 bytes`

## analysis and conclusion

The two strongest local changes compounded cleanly. Combining shorter sequence length with moderate weight clipping beat both source experiments and established a stronger tied local recipe.

Conclusion: `TRAIN_SEQ_LEN=512` and `POST_STEP_WEIGHT_CLIP=0.5` should be treated as part of the default local stack going forward.
