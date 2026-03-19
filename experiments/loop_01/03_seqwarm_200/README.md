# Loop 01 Experiment 03: Seq Warmup 200

## command

```bash
bash experiments/loop_01/03_seqwarm_200/run.sh
```

## hypothesis

The current best run still switches to full sequence length too early. Extending the `512`-token phase from `150` to `200` steps should improve final quality. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

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

Pending run. This is the highest-confidence exploitation test because it changes only one schedule value from the current anchor.
