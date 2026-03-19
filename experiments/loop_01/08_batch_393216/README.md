# Loop 01 Experiment 08: Batch 393216

## command

```bash
bash experiments/loop_01/08_batch_393216/run.sh
```

## hypothesis

The current anchor may still be too coarse in tokens per optimizer step for a single H100. Reducing `TRAIN_BATCH_TOKENS` to `393216` may improve wallclock efficiency enough to offset the noisier optimization. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

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

Pending run. This is the “more updates in the same wallclock” batch-size test.
