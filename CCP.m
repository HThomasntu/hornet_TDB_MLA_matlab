close all
clear all
path(path,'C:\Users\PHY3HALLH\OneDrive - Nottingham Trent University\Desktop\Harriet_matlab_code\useful_matlab_function')
load masking_parameters.mat
load polygonal_areas.mat


file_name = '29-06-23.wav';

% select area of audio recording to test with CCP: 
[U S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\29-06-23.wav', [1 2]);
[U S_R] = audioread(['F:\BGOOD\Hornet Work\Hornet Videos\',file_name], [round(((15*60)+06)*S_R) round(((15*60)+15)*S_R)]);
U = single(U(:,1));
 
% Carry out the ccp on each second of recording with the 2 discriminant 2DFTs I created in PCA/DFA: 

%increment_shift = round(S_R*0.25);
increment_shift = round(S_R*1);

df_scores = [];
index_array = [];
counter = 1;


for start_time = 1:increment_shift:length(U)-(1*S_R)
    audio_section = U(start_time:start_time+(1*S_R),1);
    tdft = abs(two_D_FT_Gaussian(audio_section(:,1),mf,tr,S_R,size(audio_section,1)/(2*S_R)));
  
    tdft_cropped = tdft(4:60,:);
    
    % scaled by max
    max_tdft = max(tdft_cropped(:,1));
    scaled_audio = tdft_cropped./max_tdft;
    
    % scaled by mean 
    %scaled_audio = (1/mean(tdft_cropped(:,1,counter)))*tdft_cropped(:,:,counter);
    
    ccp = sum(new_dfa(:).*scaled_audio(:));
    ccp2 = sum(new_dfa2(:).*scaled_audio(:));
    
    df_scores(:,end+1) = [ccp ccp2];
    index_array(end+1) = start_time;
end

  
df_x = df_scores(1,:);
df_y = df_scores(2,:);   


% Save the DF scores that have been computed for this particular file name:

save([file_name(1:end-4),'.mat'],'df_x','df_y','index_array')