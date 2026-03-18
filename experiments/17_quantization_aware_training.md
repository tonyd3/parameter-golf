# Experiment 17: Quantization-Aware Training

## hypothesis

Training with quantization awareness or stronger outlier control will reduce the pre-quant to post-quant quality gap, which is directly valuable in this challenge.

## changes

- Add `POST_STEP_WEIGHT_CLIP` to `train_gpt_mlx.py`
- Clip floating 2D parameters after each optimizer step as an explicit outlier-control mechanism
- Keep the export path unchanged
- Start from the best non-shared 100-step local recipe from experiment 13:
  - pre-quant `val_loss:4.3629`
  - post-quant exact `val_loss:4.36312914`
  - post-quant exact `val_bpb:2.61415456`
- Compare `POST_STEP_WEIGHT_CLIP=0.5` and `0.25`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports post-step weight clipping through `POST_STEP_WEIGHT_CLIP`
- `exp17_clip05`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - pre-quant `val_loss:4.3185`
  - post-quant exact `val_loss:4.31843853`
  - post-quant exact `val_bpb:2.58737833`
  - `serialized_model_int8_zlib:729262 bytes`
- `exp17_clip025`
  - `POST_STEP_WEIGHT_CLIP=0.25`
  - pre-quant `val_loss:4.4673`
  - post-quant exact `val_loss:4.46739292`
  - post-quant exact `val_bpb:2.67662386`
  - `serialized_model_int8_zlib:708653 bytes`

## analysis and conclusion

This experiment came back stronger than expected. Moderate clipping at `0.5` improved both the pre-quant and post-quant metrics, and also reduced the compressed artifact size. More aggressive clipping at `0.25` over-constrained the model and hurt quality.

Conclusion: explicit outlier control is a real local win here, and `POST_STEP_WEIGHT_CLIP=0.5` is one of the strongest directions discovered so far.
