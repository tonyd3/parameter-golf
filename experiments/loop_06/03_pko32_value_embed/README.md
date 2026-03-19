# Loop 06 Experiment 03: PKO32 + Value Embedding

## command

```bash
bash experiments/loop_06/03_pko32_value_embed/run.sh
```

## hypothesis

The cleaner value-only lexical branch may compound even better than the full lexical superstack when upgraded to `PKO32`.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp03_pko32_valueembed.txt`
- `model_params:985360`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9496`
- `final_int8_zlib_roundtrip_exact val_loss:3.25410414`
- `final_int8_zlib_roundtrip_exact val_bpb:1.94968586`
- `compressed_size_bytes:1223545`

## analysis

This is a strong positive result, but it still trails the full lexical superstack. The cleaner value-only branch gets much of the gain, just not all of it.
