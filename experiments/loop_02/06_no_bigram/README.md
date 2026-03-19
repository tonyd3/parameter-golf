# Loop 02 Experiment 06: No Bigram

## command

```bash
bash experiments/loop_02/06_no_bigram/run.sh
```

## hypothesis

The current local best stack likely depends heavily on the bigram feature. Removing `BIGRAM_HASH_VOCAB` should produce a meaningful regression and quantify how much of the win is due to bigram hash. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp02_warmdown120`
- `log_path:experiments/loop_02/06_no_bigram/logs/loop02_exp06_nobigram.txt`
- `model_params:592144`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.7160`
- `pre_quant_val_bpb:2.2264`
- `final_int8_zlib_roundtrip_exact val_loss:3.71632361`
- `final_int8_zlib_roundtrip_exact val_bpb:2.22662314`
- `compressed_size_bytes:817851`
- `saved_model_bytes:2116256`

## analysis

The hypothesis was supported. Removing the bigram feature caused a clear regression from `2.15940515` to `2.22662314`, even though the model became much smaller and compressed down to `817851` bytes.

This confirms that `BIGRAM_HASH_VOCAB=2048` is carrying a meaningful portion of the local quality win. For the current local quality-oriented stack, bigram hash should remain enabled.
