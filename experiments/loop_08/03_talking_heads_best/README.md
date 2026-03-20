# Loop 08 Experiment 03: PKO32 + AltCheap8 + Value + Talking-Heads

## command

logs/loop08_exp03_talking_heads_best.txt
run_id:loop08_exp03_talking_heads_best
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:1184544 vocab_size:1024 layers:8 unique_blocks:8 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
cheap_blocks:enabled every:2 offset:1 cheap_block_mlp_mult:0
bigram_hash:enabled vocab:2048 bos_id:1
value_embed:enabled
partial_key_offset_dims:32
talking_heads:enabled
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:56 scalar_params:33 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9323 train_time:141ms step_avg:141.41ms tok_s:115872
step:2/600 train_loss:6.9570 train_time:674ms step_avg:337.10ms tok_s:30826
step:3/600 train_loss:5.9660 train_time:1155ms step_avg:385.08ms tok_s:34074
step:4/600 train_loss:5.4530 train_time:1635ms step_avg:408.67ms tok_s:34188
step:5/600 train_loss:5.2701 train_time:2115ms step_avg:422.96ms tok_s:34138
step:6/600 train_loss:5.1495 train_time:2594ms step_avg:432.39ms tok_s:34183
step:7/600 train_loss:5.0395 train_time:3073ms step_avg:439.01ms tok_s:34238
step:8/600 train_loss:4.8977 train_time:3554ms step_avg:444.21ms tok_s:34104
step:9/600 train_loss:4.8755 train_time:4034ms step_avg:448.26ms tok_s:34104
step:10/600 train_loss:4.7841 train_time:4514ms step_avg:451.39ms tok_s:34180
step:30/600 train_loss:4.3168 train_time:14230ms step_avg:474.33ms tok_s:33832
step:60/600 train_loss:3.8851 train_time:28877ms step_avg:481.28ms tok_s:33665
step:90/600 train_loss:3.8546 train_time:43692ms step_avg:485.46ms tok_s:33757
step:120/600 train_loss:3.5624 train_time:58853ms step_avg:490.44ms tok_s:33889
step:150/600 train_loss:3.5168 train_time:73583ms step_avg:490.55ms tok_s:33537
step:180/600 train_loss:3.7648 train_time:88193ms step_avg:489.96ms tok_s:33907
step:210/600 train_loss:3.5175 train_time:102908ms step_avg:490.04ms tok_s:33628
step:240/600 train_loss:3.6129 train_time:117436ms step_avg:489.32ms tok_s:33710
step:270/600 train_loss:3.2691 train_time:131980ms step_avg:488.81ms tok_s:33821
step:300/600 train_loss:3.1211 train_time:146754ms step_avg:489.18ms tok_s:33882
step:330/600 train_loss:3.3293 train_time:161643ms step_avg:489.83ms tok_s:33561
step:360/600 train_loss:3.2117 train_time:176462ms step_avg:490.17ms tok_s:33731
step:390/600 train_loss:3.2923 train_time:191183ms step_avg:490.21ms tok_s:33837
step:420/600 train_loss:3.1190 train_time:205778ms step_avg:489.95ms tok_s:33650
step:450/600 train_loss:3.3858 train_time:221130ms step_avg:491.40ms tok_s:33827
step:480/600 train_loss:3.2603 train_time:235771ms step_avg:491.19ms tok_s:33933
step:510/600 train_loss:3.1990 train_time:250239ms step_avg:490.67ms tok_s:34078
step:540/600 train_loss:3.1793 train_time:264756ms step_avg:490.29ms tok_s:33980
step:570/600 train_loss:3.3199 train_time:279743ms step_avg:490.78ms tok_s:33266
step:600/600 train_loss:3.1788 train_time:294382ms step_avg:490.64ms tok_s:34087
step:600/600 val_loss:3.1857 val_bpb:1.9087 train_time:299459ms step_avg:499.10ms
saved_model:logs/loop08_exp03_talking_heads_best_mlx_model.npz bytes:3710866
serialized_model_int8_zlib:1595820 bytes (payload:1733248 raw_pickle:1739570 payload_ratio:2.13x)
final_int8_zlib_roundtrip val_loss:3.1859 val_bpb:1.9088 eval_time:3335ms
final_int8_zlib_roundtrip_exact val_loss:3.18593264 val_bpb:1.90884112

## hypothesis

Head-mixing should improve attention expressivity in a 4-head model with only a small parameter increase.

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

Supported on quality, but expensive. Talking-heads delivered a strong improvement, but it was dramatically slower than the anchor because it forced a manual attention path.
