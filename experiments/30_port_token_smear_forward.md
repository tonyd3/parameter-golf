# Experiment 30: Port Token Smear Forward

## hypothesis

Smearing token embeddings one position forward will help the small model represent short-range transitions more cheaply than adding new full-capacity blocks.

## changes

- Add a one-position-forward token smear path
- Keep the rest of the stack fixed
- Start from the current best tied local stack from experiment 21:
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - comparison point: `val_bpb 2.56879698`, `729099 bytes`
- First local port uses a zero-parameter smear of the previous token embedding into the current position

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports a zero-parameter token smear path through `USE_TOKEN_SMEAR_FORWARD=1`
- `exp30_smear`
  - `USE_TOKEN_SMEAR_FORWARD=1`
  - `final_int8_zlib_roundtrip_exact val_loss:4.36487532`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.61520078`
  - `serialized_model_int8_zlib:728199 bytes`

## analysis and conclusion

This cheap lexical bias did not help. Even though it added no parameters, it substantially hurt the proxy score relative to the tied baseline.

Conclusion: token smear forward is not a promising direction for this architecture in its simple form.
