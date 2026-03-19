# Loop 02 Experiment 08: Second Input Embed On Best Stack

## command

```bash
bash experiments/loop_02/08_second_input_best/run.sh
```

## hypothesis

The second input embedding path was locally positive before and may still compound with the current best stack at `600` steps. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp05_noclip`
- `log_path:logs/loop02_exp08_secondinput.txt`
- `model_params:985360`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.6391`
- `pre_quant_val_bpb:2.1804`
- `final_int8_zlib_roundtrip_exact val_loss:3.63909101`
- `final_int8_zlib_roundtrip_exact val_bpb:2.18034948`
- `compressed_size_bytes:1146112`
- `saved_model_bytes:2903152`

## analysis

The hypothesis was only partially supported. The second input embedding remained positive in absolute terms, but it did not beat the current anchor. Its final exact score of `2.18034948` is worse than `2.14198973`, and its compressed artifact is also larger at `1146112` bytes.

This puts the second-input feature in the same bucket as value embeddings: interesting, but not good enough to displace the current best local stack.
