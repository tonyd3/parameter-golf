# Loop 06 Experiment 07: PKO32 + Shared3 12-Layer Stack

## command

```bash
bash experiments/loop_06/07_pko32_shared3_layers12/run.sh
```

## hypothesis

The best quality/bytes shared-depth stack may improve further when the attention bias is upgraded to `PKO32`.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp07_pko32_shared3.txt`
- `model_params:772364`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9718`
- `final_int8_zlib_roundtrip_exact val_loss:3.29164433`
- `final_int8_zlib_roundtrip_exact val_bpb:1.97217794`
- `compressed_size_bytes:952069`

## analysis

This is a very strong quality/bytes result. It is not the overall quality leader, but it gives up relatively little while staying far smaller than the top quality compounds.
