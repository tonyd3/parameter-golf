# Loop 05 Experiment 08: PKO16 + Value Embedding

## command

```bash
bash experiments/loop_05/08_pko16_value_embed/run.sh
```

## hypothesis

Value-side lexical features may become complementary once PKO is already improving matching behavior.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp08_pko16_valueembed.txt`
- `model_params:985360`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9770`
- `final_int8_zlib_roundtrip_exact val_loss:3.30018497`
- `final_int8_zlib_roundtrip_exact val_bpb:1.97729503`
- `compressed_size_bytes:1223300`

## analysis

This was a strong positive compound: clearly better than the PKO16 anchor, though still behind `pko32` and the top PKO compounds. Value embeddings appear to complement PKO more cleanly than they did the older non-PKO stacks.
