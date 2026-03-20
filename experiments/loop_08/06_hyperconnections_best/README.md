# Loop 08 Experiment 06: PKO32 + AltCheap8 + Value + 2-Stream Hyper Connections

## command

logs/loop08_exp06_hyperconnections_best.txt
run_id:loop08_exp06_hyperconnections_best
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:1189536 vocab_size:1024 layers:8 unique_blocks:8 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
cheap_blocks:enabled every:2 offset:1 cheap_block_mlp_mult:0
bigram_hash:enabled vocab:2048 bos_id:1
value_embed:enabled
partial_key_offset_dims:32
hyper_connections:enabled streams:2
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:40 scalar_params:50 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9323 train_time:19ms step_avg:19.09ms tok_s:858524
step:2/600 train_loss:6.9511 train_time:85ms step_avg:42.72ms tok_s:247776
step:3/600 train_loss:5.9904 train_time:147ms step_avg:48.85ms tok_s:270795
step:4/600 train_loss:5.4940 train_time:207ms step_avg:51.68ms tok_s:273114
step:5/600 train_loss:5.2963 train_time:267ms step_avg:53.34ms tok_s:274087
step:6/600 train_loss:5.1593 train_time:327ms step_avg:54.52ms tok_s:271909
step:7/600 train_loss:5.0655 train_time:387ms step_avg:55.30ms tok_s:274171
step:8/600 train_loss:4.9188 train_time:447ms step_avg:55.88ms tok_s:274282
step:9/600 train_loss:4.8738 train_time:506ms step_avg:56.26ms tok_s:276939
step:10/600 train_loss:4.7801 train_time:567ms step_avg:56.72ms tok_s:270024
step:30/600 train_loss:4.3305 train_time:1770ms step_avg:59.01ms tok_s:272071
step:60/600 train_loss:3.9005 train_time:3610ms step_avg:60.16ms tok_s:267886
step:90/600 train_loss:3.9272 train_time:5475ms step_avg:60.83ms tok_s:262455
step:120/600 train_loss:3.6198 train_time:7334ms step_avg:61.11ms tok_s:264513
step:150/600 train_loss:3.5696 train_time:9184ms step_avg:61.23ms tok_s:266135
step:180/600 train_loss:3.7910 train_time:11026ms step_avg:61.26ms tok_s:267915
step:210/600 train_loss:3.5554 train_time:12860ms step_avg:61.24ms tok_s:270358
step:240/600 train_loss:3.6662 train_time:14710ms step_avg:61.29ms tok_s:265536
step:270/600 train_loss:3.3034 train_time:16572ms step_avg:61.38ms tok_s:266626
step:300/600 train_loss:3.1584 train_time:18421ms step_avg:61.40ms tok_s:265892
step:330/600 train_loss:3.3579 train_time:20273ms step_avg:61.43ms tok_s:265837
step:360/600 train_loss:3.2499 train_time:22129ms step_avg:61.47ms tok_s:263923
step:390/600 train_loss:3.2911 train_time:23974ms step_avg:61.47ms tok_s:268330
step:420/600 train_loss:3.1487 train_time:25817ms step_avg:61.47ms tok_s:271519
step:450/600 train_loss:3.4235 train_time:28127ms step_avg:62.51ms tok_s:223350
step:480/600 train_loss:3.2936 train_time:30064ms step_avg:62.63ms tok_s:253370
step:510/600 train_loss:3.2332 train_time:31959ms step_avg:62.66ms tok_s:266446
step:540/600 train_loss:3.2128 train_time:33822ms step_avg:62.63ms tok_s:268314
step:570/600 train_loss:3.3473 train_time:35708ms step_avg:62.65ms tok_s:264399
step:600/600 train_loss:3.2091 train_time:37583ms step_avg:62.64ms tok_s:266024
step:600/600 val_loss:3.2158 val_bpb:1.9267 train_time:38616ms step_avg:64.36ms
saved_model:logs/loop08_exp06_hyperconnections_best_mlx_model.npz bytes:3730946
serialized_model_int8_zlib:1596580 bytes (payload:1743232 raw_pickle:1749540 payload_ratio:2.13x)
final_int8_zlib_roundtrip val_loss:3.2163 val_bpb:1.9270 eval_time:826ms
final_int8_zlib_roundtrip_exact val_loss:3.21626806 val_bpb:1.92701650

## hypothesis

A second residual stream may improve deep signal transport in this narrow model better than standard single-stream residuals.

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

Not supported in this lightweight implementation. The two-stream residual path landed near the old frontier but did not improve it, so this approximation does not yet justify the extra complexity.
