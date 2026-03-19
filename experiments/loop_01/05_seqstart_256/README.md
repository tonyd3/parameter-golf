# Loop 01 Experiment 05: Seq Start 256

## command

```bash
bash experiments/loop_01/05_seqstart_256/run.sh
```

## hypothesis

An even shorter early context may improve optimization efficiency enough to beat the current anchor, provided the run still transitions to `1024` early enough. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

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

Pending run. This is the most aggressive schedule exploit in the loop and tests whether cheaper early steps are still underused.
