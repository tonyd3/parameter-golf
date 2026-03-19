# Loop 05 Experiment 05: PKO16 + Shared3 12-Layer Stack

## command

```bash
bash experiments/loop_05/05_pko16_shared3_layers12/run.sh
```

## hypothesis

The promising shared-depth size frontier may recover quality once PKO is added to repair the attention pathway.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp05_pko16_shared3.txt`
- `model_params:772364`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0016`
- `final_int8_zlib_roundtrip_exact val_loss:3.34123921`
- `final_int8_zlib_roundtrip_exact val_bpb:2.00189255`
- `compressed_size_bytes:954048`

## analysis

This is not a new quality frontier, but it is a strong quality/bytes hybrid. It stays near the PKO16 anchor while compressing substantially smaller than the leading quality runs, so it remains relevant if size starts to matter more.
