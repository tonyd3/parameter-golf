# Experiment 29: Port Second Input Embedding

## hypothesis

A second token-side embedding path may let the model separate lexical identity from other token features more effectively than a single tied embedding.

## changes

- Add a second learned input embedding path
- Fuse it into the residual stream near the input
- Start from the current best tied local stack from experiment 21:
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - comparison point: `val_bpb 2.56879698`, `729099 bytes`
- Add a second learned input embedding before the initial RMSNorm

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports a second lexical input embedding through `USE_SECOND_INPUT_EMBED=1`
- `exp29_secondinput`
  - `USE_SECOND_INPUT_EMBED=1`
  - `model_params:592144`
  - `final_int8_zlib_roundtrip_exact val_loss:4.25516653`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.54946912`
  - `serialized_model_int8_zlib:828685 bytes`

## analysis and conclusion

This was another positive lexical-feature result, but it was weaker than the value-only embedding path from experiment 27. That suggests the extra lexical signal is useful, but targeting the value pathway is the cleaner intervention.

Conclusion: second input embeddings help, but value embeddings are the stronger version of this idea in the current local regime.
