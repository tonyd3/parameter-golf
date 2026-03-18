# Experiment 13: Sweep Muon Hyperparameters

## hypothesis

The current Muon settings may not be optimal for this small model, so changing `MUON_BACKEND_STEPS` and `MUON_MOMENTUM` could improve matrix updates enough to help final quality.

## changes

- Start from the current best 100-step local recipe from experiment 11:
  - `TRAIN_BATCH_TOKENS=8192`
  - `TIED_EMBED_LR=0.0375`
  - `MATRIX_LR=0.03`
  - `SCALAR_LR=0.03`
  - `WARMDOWN_ITERS=20`
  - `QK_GAIN_INIT=2.0`
  - `LOGIT_SOFTCAP=15`
  - baseline comparison point: `val_bpb 2.61667811`
- Compare `MUON_BACKEND_STEPS=3`, `5`, and `7`
- Compare constant `MUON_MOMENTUM=0.90` and `0.95` with `MUON_MOMENTUM_WARMUP_STEPS=0`
- Keep architecture and validation proxy fixed

## experiment results

- `exp13_steps3`
  - `MUON_BACKEND_STEPS=3`
  - `final_int8_zlib_roundtrip_exact val_loss:4.39992714`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.63620196`
  - `serialized_model_int8_zlib:733396 bytes`
- `exp13_steps7`
  - `MUON_BACKEND_STEPS=7`
  - `final_int8_zlib_roundtrip_exact val_loss:4.36312914`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.61415456`
  - `serialized_model_int8_zlib:732868 bytes`
- `exp13_mom090`
  - `MUON_MOMENTUM=0.90`
  - `MUON_MOMENTUM_WARMUP_STEPS=0`
  - `final_int8_zlib_roundtrip_exact val_loss:4.39296103`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.63202824`
  - `serialized_model_int8_zlib:733089 bytes`
- `exp13_mom095`
  - `MUON_MOMENTUM=0.95`
  - `MUON_MOMENTUM_WARMUP_STEPS=0`
  - `final_int8_zlib_roundtrip_exact val_loss:4.45590925`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.66974346`
  - `serialized_model_int8_zlib:733726 bytes`

## analysis and conclusion

Increasing Muon's backend orthogonalization depth from `5` to `7` produced the best result and slightly improved artifact size too. Dropping to `3` was clearly worse. That says this local recipe benefits from slightly stronger matrix update geometry, not weaker.

The constant-momentum runs both underperformed the default warmup behavior, and constant `0.95` was especially bad. In this short 100-step regime, the default momentum warmup appears to be doing useful regularization rather than just slowing the optimizer down.

Conclusion: keep the default momentum warmup, and upgrade `MUON_BACKEND_STEPS` from `5` to `7` in the current best 100-step local recipe.
