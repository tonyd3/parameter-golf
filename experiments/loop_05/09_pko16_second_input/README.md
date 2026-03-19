# Loop 05 Experiment 09: PKO16 + Second Input Embedding

## command

```bash
bash experiments/loop_05/09_pko16_second_input/run.sh
```

## hypothesis

Second-input lexical features may stack with PKO more efficiently than the full lexical superstack.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp09_pko16_secondinput.txt`
- `model_params:985360`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9881`
- `final_int8_zlib_roundtrip_exact val_loss:3.31862593`
- `final_int8_zlib_roundtrip_exact val_bpb:1.98834388`
- `compressed_size_bytes:1219910`

## analysis

This was also positive and much better than the PKO16 anchor, but slightly weaker than the value-embedding-only version. That suggests the two lexical branches are not equally useful when paired with PKO.
