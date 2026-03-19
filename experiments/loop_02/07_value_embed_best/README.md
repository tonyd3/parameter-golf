# Loop 02 Experiment 07: Value Embed On Best Stack

## command

```bash
bash experiments/loop_02/07_value_embed_best/run.sh
```

## hypothesis

Value embeddings were locally positive on their own and may compound with the current best stack. Adding `USE_VALUE_EMBED=1` on top of the anchor may improve the local proxy score. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp05_noclip`
- `log_path:logs/loop02_exp07_valueembed.txt`
- `model_params:985360`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.6350`
- `pre_quant_val_bpb:2.1779`
- `final_int8_zlib_roundtrip_exact val_loss:3.63537455`
- `final_int8_zlib_roundtrip_exact val_bpb:2.17812277`
- `compressed_size_bytes:1147080`
- `saved_model_bytes:2903138`

## analysis

The hypothesis was only partially supported. Value embeddings stayed clearly positive in absolute terms, but they did not beat the current anchor. The final exact score of `2.17812277` is worse than `2.14198973`, and the compressed artifact also grew from `1106239` bytes to `1147080` bytes.

The conclusion is that value embeddings remain a plausible secondary feature, but they should not replace the current best local stack. They may still be worth revisiting only if paired with a different schedule or size target.
