# Experiment 38: 1xH100 KV1 + Bigram + Untied Remote Run

## hypothesis

On the baseline-scale PyTorch model, reducing KV heads to `1` while adding a bigram hash embedding and an untied output head might reallocate parameters into more useful places and improve 10-minute quality on a single H100.

## changes

- Start from the published single-GPU baseline configuration
- Set `NUM_KV_HEADS=1`
- Set `BIGRAM_HASH_VOCAB=2048`
- Set `TIE_EMBEDDINGS=0`
- Use the lower-LR / softer-logit / higher-Muon-step stack:
  - `EMBED_LR=0.0375`
  - `HEAD_LR=0.0375`
  - `MATRIX_LR=0.03`
  - `SCALAR_LR=0.03`
  - `LOGIT_SOFTCAP=15`
  - `QK_GAIN_INIT=2.0`
  - `MUON_BACKEND_STEPS=7`
  - `POST_STEP_WEIGHT_CLIP=0.5`
- Keep `MAX_WALLCLOCK_SECONDS=600`
- Keep `VAL_LOSS_EVERY=0`

## experiment results

- Baseline comparison point from the same 1xH100 setup
  - `baseline_sp1024`
  - `model_params:17059912`
  - `step:414/20000` at wallclock stop
  - `final_int8_zlib_roundtrip_exact val_bpb:1.54222932`
  - `Total submission size int8+zlib:9491575 bytes`
- `exp38_h100_10min_kv1_bigram_untied`
  - `model_params:15814728`
  - `step:430/20000` at wallclock stop
  - pre-quant stop metric: `val_bpb:1.5414`
  - `Serialized model int8+zlib:9027910 bytes`
  - `Total submission size int8+zlib:9075552 bytes`
  - `final_int8_zlib_roundtrip_exact val_loss:2.63510851`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.56065969`

## analysis and conclusion

This run was smaller and slightly faster than baseline, but the quality regression was clear. The final exact score was worse than baseline by about `0.0184 val_bpb`, and even the pre-quant stop metric was already worse.

That strongly suggests the main issue was modeling quality rather than just quantization. The likely culprit is the architectural trade: `NUM_KV_HEADS=1` reduced attention capacity too aggressively, and the added bigram and untied-head parameters did not compensate within a 10-minute single-GPU run.

Conclusion: this compound architecture change is not a good 1xH100 baseline-scale direction, despite looking promising in the tiny local proxy regime.
