# Loop 06 Experiment 02: PKO32 + Lexical Superstack

## command

```bash
bash experiments/loop_06/02_pko32_lexical_superstack/run.sh
```

## hypothesis

The best lexical compound may also improve when upgraded from `PKO16` to `PKO32`.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp02_pko32_lexical.txt`
- `model_params:1116432`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9413`
- `final_int8_zlib_roundtrip_exact val_loss:3.24075556`
- `final_int8_zlib_roundtrip_exact val_bpb:1.94168810`
- `compressed_size_bytes:1336307`

## analysis

This is the new best fixed-`600` local result. The lexical superstack still compounds even after upgrading PKO, and it beats the depth compound while also compressing smaller.
