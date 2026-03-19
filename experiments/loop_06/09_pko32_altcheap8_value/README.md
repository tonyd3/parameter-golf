# Loop 06 Experiment 09: PKO32 + Alternating Cheap 8-Layer Stack + Value Embedding

## command

```bash
bash experiments/loop_06/09_pko32_altcheap8_value/run.sh
```

## hypothesis

Alternating cheap depth plus value embeddings may outperform the heavier lexical compounds once everything is upgraded to `PKO32`.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp09_pko32_altcheap8_value.txt`
- `model_params:1184288`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9254`
- `final_int8_zlib_roundtrip_exact val_loss:3.21400356`
- `final_int8_zlib_roundtrip_exact val_bpb:1.92565973`
- `compressed_size_bytes:1593264`

## analysis

This is the new best fixed-`600` local result. The best depth compound plus value embedding compounded cleanly under `PKO32`, though it is also the largest model in this loop.
