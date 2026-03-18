# Experiment 23: Scale The Best Compound Stack To 300 Iterations

## hypothesis

The local baseline was heavily undertrained, so the strongest compound recipe should benefit further from a longer run.

## changes

- Start from the best 100-step compound recipe
- Increase `ITERATIONS` to `300`
- Keep the same local validation proxy and logging style

## experiment results

- Comparison point
  - experiment 22 100-step stack: `val_bpb 2.53943806`
- `exp23_seq512_clip05_untied_300`
  - `ITERATIONS=300`
  - `final_int8_zlib_roundtrip_exact val_loss:3.84774494`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.30536380`
  - `serialized_model_int8_zlib:829589 bytes`

## analysis and conclusion

This was the strongest local result by a wide margin. The compound stack still had substantial headroom, and a longer run improved it dramatically.

Conclusion: the best local proxy recipe so far is the 300-step untied stack from this experiment.
