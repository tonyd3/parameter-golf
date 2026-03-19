# Loop 04 Experiment 01: Lexical Superstack

## command

```bash
bash experiments/loop_04/01_lexical_superstack/run.sh
```

## hypothesis

The current best stack already relies on bigram features. Adding both `USE_VALUE_EMBED=1` and `USE_SECOND_INPUT_EMBED=1` may produce a real lexical superstack that beats `loop03_exp02_batch16384_noclip_warmdown120`.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp01_lexical_superstack.txt`
- `model_params:1116432`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.4294`
- `pre_quant_val_bpb:2.0547`
- `final_int8_zlib_roundtrip_exact val_loss:3.42998600`
- `final_int8_zlib_roundtrip_exact val_bpb:2.05506490`
- `compressed_size_bytes:1337766`
- `saved_model_bytes:3165520`

## analysis

The hypothesis was supported. Adding both value and second-input embeddings on top of the current best fixed-600 stack improved the final exact proxy score from `2.06218386` to `2.05506490`, a gain of about `0.0071 val_bpb`.

The tradeoff is clear: this win cost bytes. The compressed artifact grew from `1105923` bytes to `1337766` bytes. So this is a quality-positive moonshot, but not an obviously better quality/size tradeoff than the anchor.
