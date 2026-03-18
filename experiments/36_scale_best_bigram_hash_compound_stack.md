# Experiment 36: Scale The Best Bigram-Hash Compound Stack

## hypothesis

If the bigram-hash compound stack improves the 100-step regime, it should benefit even more from a longer 300-step run.

## changes

- Start from the best result from experiment 35
- Increase `ITERATIONS` to `300`
- Keep the same local validation proxy

## experiment results

- Comparison point
  - experiment 35 100-step compound stack: `val_bpb 2.41771924`
- `exp36_bigram2048_seq512_clip05_untied_300`
  - `ITERATIONS=300`
  - `model_params:854288`
  - `final_int8_zlib_roundtrip_exact val_loss:3.75868869`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.25200604`
  - `serialized_model_int8_zlib:1055717 bytes`

## analysis and conclusion

This is the strongest local proxy result so far. The bigram-hash compound stack still had substantial headroom at 100 steps, and the longer run converted that into a clear additional gain.

Conclusion: this is now the leading local quality recipe in the repo.
