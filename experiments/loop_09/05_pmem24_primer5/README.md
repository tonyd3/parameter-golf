# Loop 09 Experiment 05: Persistent Memory 24 + Primer k=5

## command

```bash
bash experiments/loop_09/05_pmem24_primer5/run.sh
```

## hypothesis

If both memory size and Primer are individually positive, their combination may push the frontier further than either alone.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp05_pmem24_primer5.txt`
- `model_params:1243680`
- `steps_reached:600`
- `pre_quant_val_bpb:1.8910`
- `final_int8_zlib_roundtrip_exact val_loss:3.15677762`
- `final_int8_zlib_roundtrip_exact val_bpb:1.89137299`
- `compressed_size_bytes:1707973`

## analysis

This is the best result in loop 09. `pmem24` plus `primer5` beat both ingredients individually, so this looks like the new local quality frontier coming out of the loop.
