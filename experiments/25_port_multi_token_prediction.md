# Experiment 25: Port Multi-Token Prediction

## hypothesis

Training the model to predict multiple future tokens as an auxiliary objective will improve representation learning enough to lower final next-token `val_bpb` after compression.

## changes

- Add a training-only auxiliary loss for future-token prediction
- Keep evaluation on the standard next-token metric
- Start from the current best tied local stack from experiment 21:
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - comparison point: `val_bpb 2.56879698`
- Use a minimal equal-weight local port with `MTP_TOKENS=2`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports training-only multi-token prediction through `MTP_TOKENS`
- `exp25_mtp2`
  - `MTP_TOKENS=2`
  - `final_int8_zlib_roundtrip_exact val_loss:4.67364788`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.80020085`
  - `serialized_model_int8_zlib:728846 bytes`

## analysis and conclusion

The simplest local MTP port was strongly negative. It made training noticeably slower and badly hurt final next-token quality on the proxy metric.

Conclusion: MTP is not ruled out forever, but the naive equal-weight version is not the right port. If revisited later, it should be done with a more faithful weighting scheme and probably only after stronger baselines are locked in.
