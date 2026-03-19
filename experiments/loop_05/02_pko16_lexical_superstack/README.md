# Loop 05 Experiment 02: PKO16 + Lexical Superstack

## command

```bash
bash experiments/loop_05/02_pko16_lexical_superstack/run.sh
```

## hypothesis

Partial key offset may combine well with richer lexical side channels, producing a stronger compound model than either family achieved alone.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp02_pko16_lexical.txt`
- `model_params:1116432`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9704`
- `final_int8_zlib_roundtrip_exact val_loss:3.28895974`
- `final_int8_zlib_roundtrip_exact val_bpb:1.97056948`
- `compressed_size_bytes:1336971`

## analysis

This nearly matched the new best result and confirms that PKO compounds well with stronger lexical side channels. It is slightly worse than `pko16_altcheap8`, but better on compressed size, so it remains a serious quality contender.
