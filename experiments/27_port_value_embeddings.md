# Experiment 27: Port Value Embeddings

## hypothesis

Adding a value-side feature path will improve attention quality and token representation in a way that is especially useful for small parameter budgets.

## changes

- Add a lightweight value embedding path or value residual path
- Keep the main attention structure fixed at first
- Start from the current best tied local stack from experiment 21:
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - comparison point: `val_bpb 2.56879698`, `729099 bytes`
- Add a separate token embedding table that feeds only the attention value projection

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports a lexical value path through `USE_VALUE_EMBED=1`
- `exp27_valueembed`
  - `USE_VALUE_EMBED=1`
  - `model_params:592144`
  - `final_int8_zlib_roundtrip_exact val_loss:4.21012449`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.52248233`
  - `serialized_model_int8_zlib:829750 bytes`

## analysis and conclusion

This local port was a real win. Feeding a separate lexical embedding into the value projection improved the tied baseline substantially, which supports the idea that small models benefit from giving the attention values a cleaner token-identity signal.

Conclusion: value embeddings are promising, but the first bigram-hash port still looks stronger per added byte.
