# Loop 05 Experiment 10: PKO16 + Shared1 12-Layer Stack

## command

```bash
bash experiments/loop_05/10_pko16_shared1_layers12/run.sh
```

## hypothesis

The extreme shared-depth regime may become much more usable once PKO is added, producing a strong quality/size outlier.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp10_pko16_shared1.txt`
- `model_params:607492`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0636`
- `final_int8_zlib_roundtrip_exact val_loss:3.44490671`
- `final_int8_zlib_roundtrip_exact val_bpb:2.06400459`
- `compressed_size_bytes:645535`

## analysis

PKO improved the extreme shared-depth regime a little, but not enough to make it quality-competitive. It remains interesting only as an extreme size frontier reference.
