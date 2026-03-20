# Loop 08 Experiment 05: PKO32 + AltCheap8 + Value + Persistent Memory 16

## command

logs/loop08_exp05_persistent_memory16_best.txt
run_id:loop08_exp05_persistent_memory16_best
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:1217056 vocab_size:1024 layers:8 unique_blocks:8 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
cheap_blocks:enabled every:2 offset:1 cheap_block_mlp_mult:0
bigram_hash:enabled vocab:2048 bos_id:1
value_embed:enabled
partial_key_offset_dims:32
persistent_memory_tokens:16
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:40 scalar_params:49 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9328 train_time:32ms step_avg:32.44ms tok_s:505201
step:2/600 train_loss:6.8691 train_time:120ms step_avg:60.07ms tok_s:187209
step:3/600 train_loss:5.8528 train_time:203ms step_avg:67.59ms tok_s:198944
step:4/600 train_loss:5.4934 train_time:280ms step_avg:70.09ms tok_s:211733
step:5/600 train_loss:5.2888 train_time:360ms step_avg:71.90ms tok_s:207516
step:6/600 train_loss:5.1587 train_time:437ms step_avg:72.77ms tok_s:213156
step:7/600 train_loss:5.0613 train_time:513ms step_avg:73.35ms tok_s:213842
step:8/600 train_loss:4.9358 train_time:590ms step_avg:73.72ms tok_s:215378
step:9/600 train_loss:4.8720 train_time:668ms step_avg:74.28ms tok_s:208645
step:10/600 train_loss:4.7923 train_time:747ms step_avg:74.71ms tok_s:209124
step:30/600 train_loss:4.3524 train_time:2316ms step_avg:77.19ms tok_s:212326
step:60/600 train_loss:3.8912 train_time:4679ms step_avg:77.98ms tok_s:212822
step:90/600 train_loss:3.9090 train_time:7022ms step_avg:78.02ms tok_s:207573
step:120/600 train_loss:3.6076 train_time:9380ms step_avg:78.17ms tok_s:207792
step:150/600 train_loss:3.5453 train_time:11770ms step_avg:78.46ms tok_s:207297
step:180/600 train_loss:3.7692 train_time:14263ms step_avg:79.24ms tok_s:198020
step:210/600 train_loss:3.5382 train_time:16693ms step_avg:79.49ms tok_s:210110
step:240/600 train_loss:3.6393 train_time:19070ms step_avg:79.46ms tok_s:205198
step:270/600 train_loss:3.2806 train_time:21487ms step_avg:79.58ms tok_s:208399
step:300/600 train_loss:3.1219 train_time:23913ms step_avg:79.71ms tok_s:120472
step:330/600 train_loss:3.3244 train_time:26790ms step_avg:81.18ms tok_s:199005
step:360/600 train_loss:3.2273 train_time:29260ms step_avg:81.28ms tok_s:192491
step:390/600 train_loss:3.2771 train_time:31695ms step_avg:81.27ms tok_s:207074
step:420/600 train_loss:3.1125 train_time:34380ms step_avg:81.86ms tok_s:183177
step:450/600 train_loss:3.4010 train_time:37006ms step_avg:82.23ms tok_s:178557
step:480/600 train_loss:3.2478 train_time:39523ms step_avg:82.34ms tok_s:200029
step:510/600 train_loss:3.1920 train_time:42139ms step_avg:82.63ms tok_s:194333
step:540/600 train_loss:3.1745 train_time:44669ms step_avg:82.72ms tok_s:203026
step:570/600 train_loss:3.3040 train_time:47089ms step_avg:82.61ms tok_s:204403
step:600/600 train_loss:3.1741 train_time:49477ms step_avg:82.46ms tok_s:208270
step:600/600 val_loss:3.1824 val_bpb:1.9068 train_time:51967ms step_avg:86.61ms
saved_model:logs/loop08_exp05_persistent_memory16_best_mlx_model.npz bytes:3840866
serialized_model_int8_zlib:1659207 bytes (payload:1798272 raw_pickle:1804522 payload_ratio:2.12x)
final_int8_zlib_roundtrip val_loss:3.1828 val_bpb:1.9070 eval_time:1565ms
final_int8_zlib_roundtrip_exact val_loss:3.18278384 val_bpb:1.90695453

## hypothesis

A larger memory bank may outperform the 8-token memory if the model is currently memory-capacity limited.

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

Strongly supported. Sixteen memory slots produced the best result in the loop, suggesting the model was still memory-capacity limited and that persistent memory is currently the strongest moonshot family.
