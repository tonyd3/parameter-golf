# Loop 04 Experiment 05: Partial Key Offset 16

## command

```bash
bash experiments/loop_04/05_partial_key_offset16/run.sh
```

## hypothesis

Partial key offset was negative earlier, but it may become beneficial on the stronger current stack with batch `16384`, no clip, and longer warmdown.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp05_partialkey16.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.3297`
- `pre_quant_val_bpb:1.9950`
- `final_int8_zlib_roundtrip_exact val_loss:3.33028483`
- `final_int8_zlib_roundtrip_exact val_bpb:1.99532927`
- `compressed_size_bytes:1105520`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was strongly supported. Partial key offset, which had been a loser on earlier weaker stacks, became a major win on the current best fixed-600 recipe. The final exact proxy score improved from `2.06218386` to `1.99532927`, a gain of about `0.0669 val_bpb`, with almost no meaningful size change.

This is the new best completed fixed-600 local result in the repo. The lesson is that some moonshot ideas are highly context-dependent: they may only become beneficial once the surrounding optimizer, feature stack, and batch regime are strong enough.
