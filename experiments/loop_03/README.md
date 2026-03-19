# Loop 03

This loop starts from the winning findings in `loop_02`.

Current best standard local result within this loop:

- `loop03_exp02_batch16384_noclip_warmdown120`
- `final_int8_zlib_roundtrip_exact val_bpb:2.06218386`

Exploratory step-scaling results also exist:

- `loop03_exp03_iters900_best`
- `loop03_exp04_iters1200_best`

Those longer runs are useful evidence that the stack is still undertrained, but they are no longer the default comparison anchor now that local loops are standardized to `ITERATIONS=600`.

First pilot hypothesis:

- combine the two strongest independent wins from `loop_02`
  - `TRAIN_BATCH_TOKENS=16384`
  - `POST_STEP_WEIGHT_CLIP=0.0`

The initial pilot for this loop is documented in `01_batch16384_noclip`.

## Next Hypothesis

The next clean extension is:

- keep `TRAIN_BATCH_TOKENS=16384`
- keep `POST_STEP_WEIGHT_CLIP=0.0`
- increase `WARMDOWN_ITERS` from `60` to `120`

This is documented in `02_batch16384_noclip_warmdown120`.

## Next Hypothesis

Under the fixed `ITERATIONS=600` rule, the next local loop should start from `loop03_exp02_batch16384_noclip_warmdown120` and re-test only other high-value knobs at the same iteration budget.
