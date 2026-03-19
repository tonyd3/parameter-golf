# Loop 02 Experiment 04: Retie Embeddings

## command

```bash
bash experiments/loop_02/04_retie_embeddings/run.sh
```

## hypothesis

Untying helped at `300` steps, but over a longer `600`-step local run the tied head may regularize better and compress slightly better. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp05_noclip`
- `log_path:logs/loop02_exp04_retie.txt`
- `model_params:723216`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.7294`
- `pre_quant_val_bpb:2.2344`
- `final_int8_zlib_roundtrip_exact val_loss:3.72950745`
- `final_int8_zlib_roundtrip_exact val_bpb:2.23452219`
- `compressed_size_bytes:944823`
- `saved_model_bytes:2116262`

## analysis

The hypothesis was not supported. Re-tying embeddings caused a clear regression from `2.14198973` to `2.23452219`, even though the compressed artifact shrank materially from `1106239` bytes to `944823` bytes.

This means untied embeddings are still a real contributor to local proxy quality on the current stack. For quality-oriented local iteration, `TIE_EMBEDDINGS=0` should remain in place.
