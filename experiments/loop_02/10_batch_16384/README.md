# Loop 02 Experiment 10: Batch 16384

## command

```bash
bash experiments/loop_02/10_batch_16384/run.sh
```

## hypothesis

At `600` local steps, a larger token batch may improve stability enough to beat the default `8192`-token batch. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp05_noclip`
- `log_path:logs/loop02_exp10_batch16384.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.5410`
- `pre_quant_val_bpb:2.1216`
- `final_int8_zlib_roundtrip_exact val_loss:3.54106236`
- `final_int8_zlib_roundtrip_exact val_bpb:2.12161593`
- `compressed_size_bytes:1044469`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was supported. Increasing `TRAIN_BATCH_TOKENS` from `8192` to `16384` improved the final exact proxy score from `2.14198973` to `2.12161593`, a gain of about `0.0204 val_bpb`. The compressed artifact stayed effectively flat, changing from `1106239` bytes for the no-clip anchor to `1044469` bytes here.

This is now the best completed local proxy result in `loop_02`. The most natural next step is to combine the two winning directions: keep `TRAIN_BATCH_TOKENS=16384` and also remove `POST_STEP_WEIGHT_CLIP`.
