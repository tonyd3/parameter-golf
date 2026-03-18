# Experiment 19: Sweep Tokenizer Families

## hypothesis

The best tokenizer for this challenge is not obvious; a smaller or larger SentencePiece vocab may improve the tradeoff between embedding bytes, tokens-per-byte, and context efficiency.

## changes

- Local approximation rather than full challenge-faithful retokenization
- Build a miniature matched corpus by decoding a fixed sample of documents from the local `sp1024` shard
- Retrain local SentencePiece tokenizers for `sp512` and `sp2048` on that same decoded sample
- Export miniature paired datasets for `sp1024`, `sp512`, and `sp2048`
- Run matched 50-step MLX jobs with the same model shape and optimizer recipe on each mini dataset

## experiment results

- Local tokenizer stats on the same decoded sample
  - `sp512`: `val_tokens_per_byte 0.54509409`
  - `sp1024`: `val_tokens_per_byte 0.41693630`
  - `sp2048`: `val_tokens_per_byte 0.35397284`
- `exp19_mini_sp1024`
  - `final_int8_zlib_roundtrip_exact val_loss:4.67215490`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.81002274`
  - `serialized_model_int8_zlib:726637 bytes`
- `exp19_mini_sp512`
  - `final_int8_zlib_roundtrip_exact val_loss:3.94710922`
  - `final_int8_zlib_roundtrip_exact val_bpb:3.10396623`
  - `serialized_model_int8_zlib:713493 bytes`
- `exp19_mini_sp2048`
  - `final_int8_zlib_roundtrip_exact val_loss:5.22555494`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.66824120`
  - `serialized_model_int8_zlib:839666 bytes`

## analysis and conclusion

This local mini-corpus result favored the larger tokenizer. `sp2048` used fewer tokens per byte and achieved the best `val_bpb` on the matched mini run, while `sp512` was clearly worst despite its cheaper embedding table. That means, at least on this local approximation, the context-efficiency gain from the larger vocab outweighed the extra embedding cost.

Conclusion: tokenizer size is a real lever, and larger vocab is worth serious follow-up. This result is from a local miniature reconstruction, not the full challenge export, so it should be treated as directional rather than definitive.
