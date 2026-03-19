# Loop 04 Experiment 09: Token Smear On Best Stack

## command

```bash
bash experiments/loop_04/09_token_smear_best/run.sh
```

## hypothesis

Token smearing may have failed earlier because the rest of the stack was not good enough. Re-testing it on the stronger current stack could reveal a delayed win.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp09_tokensmear.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0901`
- `final_int8_zlib_roundtrip_exact val_loss:3.48882580`
- `final_int8_zlib_roundtrip_exact val_bpb:2.09031857`
- `compressed_size_bytes:1101505`

## analysis

Token smear remained negative even on the stronger `600`-step stack. It both regressed quality against the anchor and lost badly to the best moonshots, so this looks like a direction to retire for now on the local MLX path.
