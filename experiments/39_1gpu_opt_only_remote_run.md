# Experiment 39: 1xH100 Baseline Scale With Training-Only Knobs

## hypothesis

Keeping the baseline architecture fixed while applying the safer local training-only improvements should improve the 10-minute single-H100 result without taking on risky architecture changes.

## changes

- Keep the baseline architecture exactly:
  - `NUM_LAYERS=9`
  - `MODEL_DIM=512`
  - `NUM_HEADS=8`
  - `NUM_KV_HEADS=4`
  - `MLP_MULT=2`
  - `TIE_EMBEDDINGS=1`
- Change only trainer and optimizer knobs:
  - `TIED_EMBED_LR=0.0375`
  - `MATRIX_LR=0.03`
  - `SCALAR_LR=0.03`
  - `LOGIT_SOFTCAP=15`
  - `QK_GAIN_INIT=2.0`
  - `MUON_BACKEND_STEPS=7`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - `VAL_LOSS_EVERY=0`
- Keep `WARMUP_STEPS=20`
- Keep `MAX_WALLCLOCK_SECONDS=600`

## experiment results

- Baseline comparison point from the same 1xH100 setup
  - `baseline_sp1024`
  - `model_params:17059912`
  - `step:414/20000` at wallclock stop
  - pre-quant stop metric: `val_bpb:1.5248`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.54222932`
  - `Total submission size int8+zlib:9491575 bytes`
- `exp39_h100_10min_opt_only`
  - `model_params:17059912`
  - `step:409/20000` at wallclock stop
  - pre-quant stop metric: `val_bpb:1.5449`
  - `Serialized model int8+zlib:9059096 bytes`
  - `Total submission size int8+zlib:9106738 bytes`
  - `final_int8_zlib_roundtrip_exact val_loss:2.65914241`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.57489392`

## analysis and conclusion

This was a strong regression, even though it kept the architecture fixed. The train-loss curve lagged baseline from early in the run, the step time was slightly slower, and the quantization gap widened rather than shrinking.

The most likely explanation is that the new training stack was simply too conservative for a fixed 10-minute budget. Lower learning rates, higher Muon backend steps, and post-step clipping likely combined to reduce effective learning speed, while clipping and softer logits did not produce a compensating gain in post-quant robustness.

Conclusion: the local “safe” optimization stack did not transfer cleanly to the real 1xH100 baseline regime. Future remote ablations should change one knob at a time from the original baseline rather than applying the full stack at once.
