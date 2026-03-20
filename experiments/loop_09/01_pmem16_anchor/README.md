# Loop 09 Experiment 01: Persistent Memory 16 Anchor

## command

```bash
bash experiments/loop_09/01_pmem16_anchor/run.sh
```

## hypothesis

The best result from loop_08 should reproduce cleanly as the new local anchor before we compound additional changes.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp01_pmem16_anchor.txt`
- `model_params:1217056`
- `steps_reached:600`
- `pre_quant_val_bpb:1.9075`
- `final_int8_zlib_roundtrip_exact val_loss:3.18429661`
- `final_int8_zlib_roundtrip_exact val_bpb:1.90786090`
- `compressed_size_bytes:1657104`

## analysis

The loop_08 winner reproduced cleanly. The result is effectively identical to the original `1.90753035`, so the anchor is stable enough to use for new compounds.
