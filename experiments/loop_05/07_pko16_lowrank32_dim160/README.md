# Loop 05 Experiment 07: PKO16 + Low-Rank 160-Dim Model

## command

```bash
bash experiments/loop_05/07_pko16_lowrank32_dim160/run.sh
```

## hypothesis

The low-rank wider model may work better once PKO is already carrying more of the attention-side burden.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp07_pko16_lowrank160.txt`
- `model_params:1047376`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0396`
- `final_int8_zlib_roundtrip_exact val_loss:3.40479708`
- `final_int8_zlib_roundtrip_exact val_bpb:2.03997304`
- `compressed_size_bytes:1340151`

## analysis

This remained clearly weaker than the PKO leaders, so the wider low-rank path still looks dominated. PKO did not rescue the low-rank width experiment enough to make it interesting.
