# Loop 05 Experiment 06: PKO16 + Shared2 8-Layer Stack

## command

```bash
bash experiments/loop_05/06_pko16_shared2_layers8/run.sh
```

## hypothesis

The more aggressive shared-depth regime may become quality-competitive once PKO is added.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp06_pko16_shared2.txt`
- `model_params:689672`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0222`
- `final_int8_zlib_roundtrip_exact val_loss:3.37570333`
- `final_int8_zlib_roundtrip_exact val_bpb:2.02254162`
- `compressed_size_bytes:798494`

## analysis

The more aggressive shared2 regime is still weaker than `shared3`, even with PKO16 added. It remains interesting for size efficiency, but it is no longer the most promising quality/bytes hybrid in this loop.
