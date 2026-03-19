# Loop 01 Experiment 01: Seq Warmup Only

## command

```bash
bash experiments/loop_01/01_seqwarm_only/run.sh
```

## hypothesis

The sequence-length warmup from `512 -> 1024` is carrying most of the gain from `exp43`, and the `MIN_LR_SCALE=0.1` floor is secondary. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

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

Pending run. Promote only if the final exact score matches or exceeds the current anchor with fewer moving parts.
