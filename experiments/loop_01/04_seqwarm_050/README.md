# Loop 01 Experiment 04: Seq Warmup 50

## command

```bash
bash experiments/loop_01/04_seqwarm_050/run.sh
```

## hypothesis

The short-context phase may only need to stabilize the earliest updates. Shortening sequence warmup from `150` to `50` steps may preserve most of the gain while spending more time at full context. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

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

Pending run. This is the main negative-control variant for the warmup schedule length.
