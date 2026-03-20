# Loop 09 Experiment 08: Persistent Memory 16 + Primer k=5 + Shared3 Layers12

## command

```bash
bash experiments/loop_09/08_pmem16_primer5_shared3/run.sh
```

## hypothesis

Shared-depth may benefit from both persistent memory and stronger local bias, producing a better quality/bytes hybrid than memory alone.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp08_pmem16_primer5_shared3.txt`
- `model_params:788492`
- `steps_reached:600`
- `pre_quant_val_bpb:1.9413`
- `final_int8_zlib_roundtrip_exact val_loss:3.24054956`
- `final_int8_zlib_roundtrip_exact val_bpb:1.94156468`
- `compressed_size_bytes:983048`

## analysis

Primer improved the shared-depth memory hybrid, but not enough to challenge the full-depth frontier. This remains a quality/bytes candidate rather than a pure quality leader.
