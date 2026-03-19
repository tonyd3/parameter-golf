# Loop 04 Experiment 04: Shared 2-of-8 Lexical Superstack

## command

```bash
bash experiments/loop_04/04_shared2_layers8_lexical/run.sh
```

## hypothesis

If compute reuse and richer lexical features are both good directions, combining them may unlock a better regime than either alone.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp04_shared2_layers8_lexical.txt`
- `model_params:951816`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.4722`
- `pre_quant_val_bpb:2.0804`
- `final_int8_zlib_roundtrip_exact val_loss:3.47276950`
- `final_int8_zlib_roundtrip_exact val_bpb:2.08069849`
- `compressed_size_bytes:1032495`
- `saved_model_bytes:2502480`

## analysis

The hypothesis was not supported as a raw quality win. The shared-plus-lexical compound did not beat the anchor and landed at `2.08069849`, still worse than `2.06218386`.

However, it is meaningfully better than the pure shared `2-of-8` stack while keeping a smaller compressed artifact than the lexical superstack. So this looks like a middle-ground quality/size tradeoff, not a new frontier.
