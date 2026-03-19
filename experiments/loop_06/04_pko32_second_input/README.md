# Loop 06 Experiment 04: PKO32 + Second Input Embedding

## command

```bash
bash experiments/loop_06/04_pko32_second_input/run.sh
```

## hypothesis

Second-input features may scale more cleanly than the heavier lexical stacks once the attention bias is upgraded to `PKO32`.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp04_pko32_secondinput.txt`
- `model_params:985360`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9580`
- `final_int8_zlib_roundtrip_exact val_loss:3.26843596`
- `final_int8_zlib_roundtrip_exact val_bpb:1.95827272`
- `compressed_size_bytes:1220709`

## analysis

This improved over the plain `PKO32` anchor, but it is clearly weaker than both value-only and full lexical superstack. Second-input alone looks like the less useful lexical branch here.
