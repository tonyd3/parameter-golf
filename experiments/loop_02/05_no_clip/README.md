# Loop 02 Experiment 05: No Clip

## command

```bash
bash experiments/loop_02/05_no_clip/run.sh
```

## hypothesis

Weight clipping was helpful earlier, but the current stack may no longer need it once we train for `600` steps. Removing `POST_STEP_WEIGHT_CLIP` will show whether clipping is still carrying the local result. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp02_warmdown120`
- `log_path:experiments/loop_02/05_no_clip/logs/loop02_exp05_noclip.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.5747`
- `pre_quant_val_bpb:2.1417`
- `final_int8_zlib_roundtrip_exact val_loss:3.57506704`
- `final_int8_zlib_roundtrip_exact val_bpb:2.14198973`
- `compressed_size_bytes:1106239`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was supported. Removing `POST_STEP_WEIGHT_CLIP` improved the final exact proxy score from `2.15940515` to `2.14198973`, a gain of about `0.0174 val_bpb`. That means clipping is no longer helping on this longer `600`-step local stack.

The tradeoff is compression. The compressed artifact grew from `1046216` bytes to `1106239` bytes, so this is a quality win with a size cost. For the current local proxy objective, this should still become the new local quality anchor.
