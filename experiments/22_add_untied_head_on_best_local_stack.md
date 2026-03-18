# Experiment 22: Add Untied Head On The Best Local Stack

## hypothesis

If the untied output head and the stronger local optimization recipe improve different bottlenecks, combining them should beat either change in isolation.

## changes

- Start from the best local compound stack found so far
- Set `TIE_EMBEDDINGS=0`
- Compare quality gain against artifact growth

## experiment results

- Comparison point
  - experiment 21 compound tied stack: `val_bpb 2.56879698`, `729099 bytes`
- `exp22_seq512_clip05_untied`
  - `TIE_EMBEDDINGS=0`
  - `model_params:592144`
  - `final_int8_zlib_roundtrip_exact val_loss:4.23842430`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.53943806`
  - `serialized_model_int8_zlib:827611 bytes`

## analysis and conclusion

The untied head remained beneficial even after stacking the strongest local optimization changes. It improved `val_bpb` again, though the compressed artifact grew by about `98 KB`.

Conclusion: if the goal is pure local quality, the untied head belongs in the best stack. If the goal is tighter size efficiency, the tied version from experiment 21 is still attractive.
