# Loop 06 Experiment 06: PKO64 Sweep

## command

```bash
bash experiments/loop_06/06_pko64/run.sh
```

## hypothesis

The upward PKO sweep may continue, though this is a higher-risk overshoot test.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp06_pko64.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9660`
- `final_int8_zlib_roundtrip_exact val_loss:3.28186202`
- `final_int8_zlib_roundtrip_exact val_bpb:1.96631690`
- `compressed_size_bytes:1106993`

## analysis

`PKO64` landed almost exactly on `PKO32`, but slightly worse. Combined with the `PKO48` result, this makes `PKO32` look like the best PKO setting among the tested widths.
