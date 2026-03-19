# Loop 01 Experiment 09: Batch 655360

## command

```bash
bash experiments/loop_01/09_batch_655360/run.sh
```

## hypothesis

The current anchor may still benefit from more stable large-batch optimization. Increasing `TRAIN_BATCH_TOKENS` to `655360` may improve final quality despite slightly heavier steps. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

## results / data

- `status:not_run_yet`
- `comparison_target:exp43_1gpu_seqwarm150_minlr01`
- `log_path:pending`
- `model_params:pending`
- `steps_reached:pending`
- `pre_quant_val_bpb:pending`
- `final_int8_zlib_roundtrip_exact val_bpb:pending`
- `compressed_size_bytes:pending`

## analysis

Pending run. This is the “fewer but more stable updates” batch-size test.
