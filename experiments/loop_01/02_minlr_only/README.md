# Loop 01 Experiment 02: Min LR Only

## command

```bash
bash experiments/loop_01/02_minlr_only/run.sh
```

## hypothesis

The nonzero learning-rate floor is carrying most of the gain from `exp43`, and the sequence-length warmup is secondary. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

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

Pending run. This experiment isolates the LR-floor effect and tells us whether the sequence schedule is truly necessary.
