# Loop 05 Experiment 04: PKO32 Sweep

## command

```bash
bash experiments/loop_05/04_pko32/run.sh
```

## hypothesis

The PKO sweet spot may be larger than `16`, allowing stronger induction bias on the improved local stack.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp04_pko32.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9661`
- `final_int8_zlib_roundtrip_exact val_loss:3.28198004`
- `final_int8_zlib_roundtrip_exact val_bpb:1.96638761`
- `compressed_size_bytes:1104729`

## analysis

Increasing PKO from `16` to `32` improved quality again and set the new local frontier. That means the PKO sweet spot has not peaked yet in this range, and `32` should be the new default for subsequent compounds.
