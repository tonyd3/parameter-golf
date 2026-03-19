# Loop 02 Experiment 03: Bigram 4096

## command

```bash
bash experiments/loop_02/03_bigram_4096/run.sh
```

## hypothesis

The local bigram feature likely still has unused capacity. Increasing `BIGRAM_HASH_VOCAB` from `2048` to `4096` should improve local proxy quality if the model can exploit the extra buckets. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp02_warmdown120`
- `log_path:experiments/loop_02/03_bigram_4096/logs/loop02_exp03_bigram4096.txt`
- `model_params:1116432`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.6120`
- `pre_quant_val_bpb:2.1641`
- `final_int8_zlib_roundtrip_exact val_loss:3.61253452`
- `final_int8_zlib_roundtrip_exact val_bpb:2.16443825`
- `compressed_size_bytes:1271908`
- `saved_model_bytes:3165058`

## analysis

The hypothesis was not supported. Increasing `BIGRAM_HASH_VOCAB` from `2048` to `4096` produced a small regression from `2.15940515` to `2.16443825` while also increasing compressed size substantially from `1046216` bytes to `1271908` bytes.

The likely conclusion is that the local bigram feature is already near the useful capacity point at `2048` buckets for this small model. This should be treated as a rejected direction for the current stack.
