# Self-Improve Loop

This file defines the default workflow for iterative model improvement in this repo.

The goal is to create a repeatable loop with:

- explicit hypotheses
- isolated experiments
- frozen code snapshots per run
- comparable results
- written analysis after every run

This document applies to both local iteration and remote H100 runs. The only difference is which trainer is copied into each experiment folder:

- `train_gpt_mlx.py` for local MLX experiments
- `train_gpt.py` for CUDA / H100 experiments

For local testing, use exactly `600` training steps by default.

Treat `ITERATIONS=600` as the fixed local comparison budget that stands in for the contest’s fixed wallclock budget.

## Core Rule

Every loop must produce `10` concrete hypotheses derived from prior evidence.

Each hypothesis becomes its own experiment folder under `experiments/`.

Each experiment folder must contain:

- a trainer snapshot
- a markdown writeup
- the exact run command
- the resulting data
- the final analysis

Do not run “mystery” experiments outside this structure.

## Loop Inputs

Each loop starts by reading:

- `EXPERIMENTS.md`
- the most recent experiment folders
- the most relevant run logs

The purpose of the read step is to answer:

1. What improved score?
2. What regressed?
3. What was inconclusive?
4. What constraints mattered?
5. What should be isolated next?

## Loop Output

Each loop must produce:

1. `10` ranked hypotheses
2. `10` experiment folders
3. `10` experiment READMEs
4. copied trainer snapshots
5. completed results and analysis after runs finish
6. an updated `EXPERIMENTS.md`

## Folder Layout

Going forward, experiment data should use folder-based layout instead of a single flat markdown file.

Recommended naming:

```text
experiments/
  loop_01/
    01_slug_name/
      README.md
      train_gpt.py
      run.sh
    02_slug_name/
      README.md
      train_gpt.py
      run.sh
    ...
    10_slug_name/
      README.md
      train_gpt.py
      run.sh
```

If the loop is local MLX instead of CUDA:

```text
experiments/
  loop_02/
    01_slug_name/
      README.md
      train_gpt_mlx.py
      run.sh
```

If needed, add extra files such as:

- `notes.txt`
- `submission.json`
- `train.log`

But the minimum required files are:

- `README.md`
- the trainer snapshot
- `run.sh`

## Loop Naming

Loop folders should be named in increasing order:

- `loop_01`
- `loop_02`
- `loop_03`

Experiment folders inside a loop should be numbered `01` through `10`.

Use short slug names that describe the main change:

- `01_seqwarm_150`
- `02_minlr_005`
- `03_batch_393216`

## Hypothesis Rules

The `10` hypotheses in a loop must come from prior evidence, not random guessing.

A good loop usually includes:

- `4` exploitation hypotheses
  - small refinements to the current best run
- `3` isolation hypotheses
  - remove or vary one change from the current best run
- `2` schedule or systems hypotheses
  - warmup, cooldown, batch size, sequence schedule, backend
- `1` wildcard hypothesis
  - one higher-risk idea motivated by the broader research direction

Each hypothesis should have:

- one primary claim
- one main variable being tested
- one comparison target

Avoid multi-change experiments unless the hypothesis is explicitly about interaction.

## Experiment Creation Rules

For each of the `10` hypotheses:

1. Create a new experiment folder.
2. Copy the active trainer into that folder.
3. Create `run.sh` with the exact command for that run.
4. Create `README.md` with the template below.
5. Make sure the experiment has a unique `RUN_ID`.

The copied trainer is important. Each experiment must freeze the exact code used for the run.

Do not rely on the mutable repo root alone for reproducibility.

## README Template

Every experiment `README.md` must use this structure:

```md
# Experiment Title

## command

```bash
RUN_ID=...
...
```

## hypothesis

One short paragraph explaining what is being tested and why it might help.

## results / data

- `model_params:...`
- `steps_reached:...`
- `pre_quant_val_bpb:...`
- `final_int8_zlib_roundtrip_exact val_bpb:...`
- `compressed_size_bytes:...`
- any other directly relevant measurements

## analysis

One short paragraph explaining:

- whether the hypothesis was supported
- what likely caused the outcome
- whether this change should be promoted, rejected, or revisited
```

Keep the README short and factual.

## Run Script Rules

Every experiment must include a `run.sh` file.

That file should:

- set `set -euo pipefail`
- define the full command
- use the copied trainer in the experiment folder, not the repo root

If the experiment is local:

- set `ITERATIONS=600`
- keep `ITERATIONS` fixed across the loop unless the entire loop is explicitly a step-scaling study
- treat non-`600` local runs as exploratory, not as default comparison anchors
- do not compare a `900` or `1200` step run directly against the standard `600`-step loop frontier without labeling that comparison as exploratory

Example:

```bash
#!/usr/bin/env bash
set -euo pipefail

RUN_ID=loop01_exp01_seqwarm150 \
DATA_PATH=../../data/datasets/fineweb10B_sp1024 \
TOKENIZER_PATH=../../data/tokenizers/fineweb_1024_bpe.model \
VOCAB_SIZE=1024 \
MAX_WALLCLOCK_SECONDS=600 \
VAL_LOSS_EVERY=0 \
TRAIN_LOG_EVERY=50 \
WARMUP_STEPS=20 \
TRAIN_SEQ_LEN=1024 \
TRAIN_SEQ_LEN_START=512 \
SEQ_LEN_WARMUP_STEPS=150 \
torchrun --standalone --nproc_per_node=1 ./train_gpt.py
```

## Comparison Rules

Every experiment must state its comparison target.

Usually this is one of:

- the current global best run
- the current best local run
- the current best remote run
- the immediate parent experiment

Do not evaluate a result without saying what it is compared against.

## Promotion Rules

After all `10` runs in a loop finish:

1. Rank them by the primary metric.
2. Mark each one as:
   - promote
   - reject
   - inconclusive
3. Select the top `1` to `3` experiments for the next loop’s starting point.
4. Write down why the others are not being carried forward.

## Metric Priority

Use this priority order unless the loop explicitly says otherwise:

1. `final_int8_zlib_roundtrip_exact val_bpb`
2. total submission size
3. pre-quant quality
4. steps reached / throughput

Lower `val_bpb` is better.

If a run is faster but scores worse, it is not automatically a win.

## Local vs Remote

Local MLX loops are for:

- fast iteration
- shape and schedule testing
- relative comparisons on a fixed proxy

Remote H100 loops are for:

- real score validation
- full-val comparisons
- final promotion decisions

Local results must not be treated as final proof for remote runs.

## Default Loop Workflow

For every loop:

1. Read prior results.
2. Write `10` ranked hypotheses.
3. Create `10` experiment folders.
4. Copy the trainer into each folder.
5. Create `run.sh` and `README.md` in each folder.
6. Run the experiments.
7. Fill in results / data.
8. Write analysis.
9. Update `EXPERIMENTS.md`.
10. Start the next loop from the best promoted results.

## Non-Negotiables

- No undocumented runs.
- No changing multiple major things without saying so explicitly.
- No experiment without a frozen trainer snapshot.
- No experiment without a command.
- No experiment without written analysis.
- No promoting a run just because it “felt better”.

This process exists to keep iteration scientific, reproducible, and fast.
