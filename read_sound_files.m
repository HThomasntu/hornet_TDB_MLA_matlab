clear all

[A S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\15-12-22 B_with_sound_02.wav', [1 2]);
[A S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\15-12-22 B_with_sound_02.wav', [1 round(((22*60)+0)*S_R)]);

[B S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\15-12-22_with_sound_02.wav', [1 2]);
[B S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\15-12-22_with_sound_02.wav', [1 round(((8*60)+0)*S_R)]);

[C S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\13-10-22 shotgun.wav', [1 2]);
[C S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\13-10-22 shotgun.wav', [1 round(((3*60)+33)*S_R)]);

[D S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\13-10-22 shotgun 2.wav', [1 2]);
[D S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\13-10-22 shotgun 2.wav', [1 round(((1*60)+50)*S_R)]);

save sound_files.mat