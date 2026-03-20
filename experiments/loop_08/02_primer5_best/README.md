# Loop 08 Experiment 02: PKO32 + AltCheap8 + Value + Primer Depthwise Conv k=5

## command

logs/loop08_exp02_primer5_best.txt
run_id:loop08_exp02_primer5_best
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:1194528 vocab_size:1024 layers:8 unique_blocks:8 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
cheap_blocks:enabled every:2 offset:1 cheap_block_mlp_mult:0
bigram_hash:enabled vocab:2048 bos_id:1
value_embed:enabled
partial_key_offset_dims:32
primer_depthwise_kernel:5
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:64 scalar_params:33 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9323 train_time:39ms step_avg:38.54ms tok_s:425141
step:2/600 train_loss:6.9568 train_time:178ms step_avg:89.09ms tok_s:117523
step:3/600 train_loss:5.9663 train_time:275ms step_avg:91.59ms tok_s:169902
step:4/600 train_loss:5.4531 train_time:360ms step_avg:90.06ms tok_s:192371
step:5/600 train_loss:5.2700 train_time:434ms step_avg:86.71ms tok_s:224329
step:6/600 train_loss:5.1502 train_time:504ms step_avg:84.02ms tok_s:232632
step:7/600 train_loss:5.0399 train_time:574ms step_avg:82.05ms tok_s:234459
step:8/600 train_loss:4.8976 train_time:645ms step_avg:80.63ms tok_s:232395
step:9/600 train_loss:4.8734 train_time:715ms step_avg:79.40ms tok_s:236145
step:10/600 train_loss:4.7830 train_time:785ms step_avg:78.46ms tok_s:235093
step:30/600 train_loss:4.3173 train_time:2196ms step_avg:73.19ms tok_s:233051
step:60/600 train_loss:3.8852 train_time:4351ms step_avg:72.52ms tok_s:230295
step:90/600 train_loss:3.9198 train_time:6640ms step_avg:73.78ms tok_s:231148
step:120/600 train_loss:3.6155 train_time:9078ms step_avg:75.65ms tok_s:191562
step:150/600 train_loss:3.5654 train_time:11391ms step_avg:75.94ms tok_s:224767
step:180/600 train_loss:3.7868 train_time:13624ms step_avg:75.69ms tok_s:225902
step:210/600 train_loss:3.5454 train_time:15916ms step_avg:75.79ms tok_s:224838
step:240/600 train_loss:3.6468 train_time:18353ms step_avg:76.47ms tok_s:226435
step:270/600 train_loss:3.2961 train_time:20617ms step_avg:76.36ms tok_s:227111
step:300/600 train_loss:3.1350 train_time:22799ms step_avg:76.00ms tok_s:228608
step:330/600 train_loss:3.3441 train_time:24962ms step_avg:75.64ms tok_s:228102
step:360/600 train_loss:3.2279 train_time:27193ms step_avg:75.54ms tok_s:225258
step:390/600 train_loss:3.2768 train_time:29365ms step_avg:75.29ms tok_s:226448
step:420/600 train_loss:3.1309 train_time:31581ms step_avg:75.19ms tok_s:221993
step:450/600 train_loss:3.4101 train_time:33830ms step_avg:75.18ms tok_s:222072
step:480/600 train_loss:3.2705 train_time:36002ms step_avg:75.00ms tok_s:226613
step:510/600 train_loss:3.2122 train_time:38272ms step_avg:75.04ms tok_s:223847
step:540/600 train_loss:3.1902 train_time:40456ms step_avg:74.92ms tok_s:225516
step:570/600 train_loss:3.3063 train_time:43358ms step_avg:76.07ms tok_s:215800
step:600/600 train_loss:3.1950 train_time:45570ms step_avg:75.95ms tok_s:224408
step:600/600 val_loss:3.1938 val_bpb:1.9136 train_time:46865ms step_avg:78.11ms
saved_model:logs/loop08_exp02_primer5_best_mlx_model.npz bytes:3752802
serialized_model_int8_zlib:1614345 bytes (payload:1753216 raw_pickle:1760135 payload_ratio:2.13x)
final_int8_zlib_roundtrip val_loss:3.1943 val_bpb:1.9138 eval_time:889ms
final_int8_zlib_roundtrip_exact val_loss:3.19426942 val_bpb:1.91383608

## hypothesis

If Primer-style local bias is real here, a slightly longer kernel may improve token-pattern capture beyond k=3, though it is a higher-risk overshoot.

## results / data

- 
- 
- 
- 
- 
- 
- 
- 
- 

## analysis

Supported. The longer kernel slightly outperformed k=3, so this local regime appears to want a somewhat wider short-range receptive field rather than the smallest conv.
