# Loop 01 Experiment 06: Min LR 0.05

## command

```bash
bash experiments/loop_01/06_minlr_005/run.sh
```

## hypothesis

The current LR floor may be a little too high. Lowering `MIN_LR_SCALE` from `0.1` to `0.05` may improve late-run flexibility without losing the main benefit. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

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

Pending run. This is the main fine-tune around the winning LR-floor value.
