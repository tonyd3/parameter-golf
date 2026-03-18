# Experiment 28: Port Partial Key Offset

## hypothesis

Shifting part of the key representation across positions will make induction-like patterns easier to learn, especially in small attention blocks.

## changes

- Apply a partial positional shift to a subset of key dimensions
- Start with the long-context or all-layer local approximation first
- Start from the current best tied local stack from experiment 21:
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - comparison point: `val_bpb 2.56879698`
- First local approximation uses `PARTIAL_KEY_OFFSET_DIMS=16`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports a local partial-key-offset approximation through `PARTIAL_KEY_OFFSET_DIMS`
- `exp28_pko16`
  - `PARTIAL_KEY_OFFSET_DIMS=16`
  - `final_int8_zlib_roundtrip_exact val_loss:4.29817057`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.57523484`
  - `serialized_model_int8_zlib:728939 bytes`

## analysis and conclusion

This first local approximation did not help. It was close to the tied baseline, but still worse.

Conclusion: partial key offset is not promising in this simple form. It may need a more faithful implementation or different placement to be worth revisiting.
