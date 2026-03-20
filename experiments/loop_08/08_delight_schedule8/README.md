# Loop 08 Experiment 08: PKO32 + DeLighT-Style 8-Layer Uneven Block Schedule

## command

logs/loop08_exp08_delight_schedule8.txt
run_id:loop08_exp08_delight_schedule8
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:1315360 vocab_size:1024 layers:8 unique_blocks:8 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
block_mlp_mults:0,1,1,1,2,2,2,3
bigram_hash:enabled vocab:2048 bos_id:1
partial_key_offset_dims:32
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:46 scalar_params:33 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9337 train_time:21ms step_avg:21.11ms tok_s:776462
step:2/600 train_loss:6.8952 train_time:91ms step_avg:45.46ms tok_s:235399
step:3/600 train_loss:5.8819 train_time:156ms step_avg:51.96ms tok_s:253060
step:4/600 train_loss:5.4855 train_time:221ms step_avg:55.13ms tok_s:254132
step:5/600 train_loss:5.2782 train_time:285ms step_avg:56.98ms tok_s:255305
step:6/600 train_loss:5.1485 train_time:350ms step_avg:58.35ms tok_s:252077
step:7/600 train_loss:5.0796 train_time:415ms step_avg:59.27ms tok_s:253299
step:8/600 train_loss:4.9223 train_time:479ms step_avg:59.91ms tok_s:255500
step:9/600 train_loss:4.8617 train_time:545ms step_avg:60.50ms tok_s:251807
step:10/600 train_loss:4.7539 train_time:609ms step_avg:60.87ms tok_s:256017
step:30/600 train_loss:4.3561 train_time:1911ms step_avg:63.71ms tok_s:252120
step:60/600 train_loss:3.9346 train_time:4352ms step_avg:72.53ms tok_s:241417
step:90/600 train_loss:3.9648 train_time:6378ms step_avg:70.87ms tok_s:245156
step:120/600 train_loss:3.7083 train_time:8353ms step_avg:69.61ms tok_s:250115
step:150/600 train_loss:3.6279 train_time:10320ms step_avg:68.80ms tok_s:252417
step:180/600 train_loss:3.8308 train_time:12305ms step_avg:68.36ms tok_s:228838
step:210/600 train_loss:3.5988 train_time:14342ms step_avg:68.30ms tok_s:248668
step:240/600 train_loss:3.6897 train_time:16320ms step_avg:68.00ms tok_s:243890
step:270/600 train_loss:3.3389 train_time:18283ms step_avg:67.71ms tok_s:250716
step:300/600 train_loss:3.1968 train_time:20234ms step_avg:67.45ms tok_s:252320
step:330/600 train_loss:3.3699 train_time:22231ms step_avg:67.37ms tok_s:244635
step:360/600 train_loss:3.2777 train_time:24233ms step_avg:67.31ms tok_s:246319
step:390/600 train_loss:3.3438 train_time:26220ms step_avg:67.23ms tok_s:252098
step:420/600 train_loss:3.1813 train_time:28172ms step_avg:67.08ms tok_s:255614
step:450/600 train_loss:3.4409 train_time:30132ms step_avg:66.96ms tok_s:252164
step:480/600 train_loss:3.2981 train_time:32106ms step_avg:66.89ms tok_s:248861
step:510/600 train_loss:3.2316 train_time:34091ms step_avg:66.85ms tok_s:243136
step:540/600 train_loss:3.2167 train_time:36063ms step_avg:66.78ms tok_s:253682
step:570/600 train_loss:3.3562 train_time:38027ms step_avg:66.71ms tok_s:252305
step:600/600 train_loss:3.2037 train_time:40005ms step_avg:66.68ms tok_s:254144
step:600/600 val_loss:3.2183 val_bpb:1.9282 train_time:41123ms step_avg:68.54ms
saved_model:logs/loop08_exp08_delight_schedule8_mlx_model.npz bytes:4493738
serialized_model_int8_zlib:1965310 bytes (payload:2123904 raw_pickle:2129445 payload_ratio:2.11x)
final_int8_zlib_roundtrip val_loss:3.2186 val_bpb:1.9284 eval_time:846ms
final_int8_zlib_roundtrip_exact val_loss:3.21860218 val_bpb:1.92841497

## hypothesis

A deliberately uneven MLP allocation across depth may beat the crude alternating-cheap heuristic.

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

Not supported. The more intentional uneven schedule still lost to the simpler alternating-cheap stack, so our current heuristic remains the better depth-allocation rule locally.
