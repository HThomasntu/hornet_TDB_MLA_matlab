clear all

path(path,'C:\Users\PHY3HALLH\OneDrive - Nottingham Trent University\Desktop\Harriet_matlab_code\useful_matlab_function')
load sound_files.mat

% Letters refer to the soundfile that each came from (see TDB in third
% training for list of files in the code)

[E S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\16-05-23.wav', [1 2]);
[E S_R] = audioread('F:\BGOOD\Hornet Work\Hornet Videos\16-05-23.wav', [1 round(((5*60)+20)*S_R)]);

% Irregular hornet, not detected (A)
timings_IHND = [21 67 75 81 91 171 179 208 221 232 239 248 253 506 520 523 532 539 555 563 882];

% Irregular hornet, detected (A)
timings_IHD = [15 37 63 85 197 204 217 225 263 269 442 510 515 526 536 1254 1279.5];

% Regular hornet, always detected (C)
timings_RHD1 = [3 4 5 9 10 17 18 40 41 62 68 70 72 79 85 91 98 107.5 112 118 120 155 163 166 172 185 199];

% Regular hornet, always detected (D)
timings_RHD2 = [3 4 5 6 7 10 11 13 14 15 22 39 41 46 47 59 60 61 64 70 85 92 102];

% Bees detected as hornet (B)
%timings_BH = [84 92 94 99 115 124 125 129 132 142 174 209 211 238 266 271 320 324 339 342.5 354 355 361 362 363 380 391 400 402 415 417];
timings_BH = [83 91 93 98 114 123 124 128 131 141 174 208 211 216 237 265.5 319 323 338 341.5 350 353 355 360 361 362 380 391 400 401 414 417]; 

% Bees not detected as hornet (A)
timings_BEE = [136 148 157 167 307.5 309 310 312 329 357.5 366 368 373 385 388 395 427 477 493 500 579 590 631 634 638 667];

% 16.05.23 bees (E)
timings_BEE16 = [8.5 12.7 19 20.7 31 39.5 42 46 49.5 52 57 61 65 67.5 71.5 75 80.5 82.5 84.5 91 93 96 98 100.5 106 119.5 123 130:133 134.5 135.5 141 146 149 153 154 155.5 168 171.5 174.4 182 185 193 200.5 203 211 215.5 229 238 242 251.5 254];

% Background (B)
timings_BGB = [52 53 61:63 101 102 109 117 147 150 162 218:233 243:256 274:278 410:412 433:436 450:456 459:463];

% Background (C)
timings_BGC = [35:37 44:51 142 143 202 203];

% 16.05.23 background (E)
timings_BGE = [6 25.5 33 35.5 37 43.5 47 74 78.7 96.7 99 102 104 237 266 279 282 288.5 305.5 310];


window_length = 0.5;
MF = 4;
tr = 0.04;


for window = 1:length(timings_IHND)
    
LL = round((timings_IHND(window)-window_length)*S_R);
UL = round((timings_IHND(window)+window_length)*S_R);

IHND_tdft(:,:,window) = two_D_FT_Gaussian(A(LL:UL,1),MF,tr,S_R,size(A,1)/(2*S_R));

end 

for window2 = 1:length(timings_IHD)
    
LL2 = round((timings_IHD(window2)-window_length)*S_R);
UL2 = round((timings_IHD(window2)+window_length)*S_R);

IHD_tdft(:,:,window2) = two_D_FT_Gaussian(A(LL2:UL2,1),MF,tr,S_R,size(A,1)/(2*S_R));

end 

for window3 = 1:length(timings_RHD1)
    
LL3 = round((timings_RHD1(window3)-window_length)*S_R);
UL3 = round((timings_RHD1(window3)+window_length)*S_R);

RHD1_tdft(:,:,window3) = two_D_FT_Gaussian(C(LL3:UL3,1),MF,tr,S_R,size(C,1)/(2*S_R));

end 

for window4 = 1:length(timings_RHD2)
    
LL4 = round((timings_RHD2(window4)-window_length)*S_R);
UL4 = round((timings_RHD2(window4)+window_length)*S_R);

RHD2_tdft(:,:,window4) = two_D_FT_Gaussian(D(LL4:UL4,1),MF,tr,S_R,size(D,1)/(2*S_R));

end 

for window5 = 1:length(timings_BH)
    
LL5 = round((timings_BH(window5)-window_length)*S_R);
UL5 = round((timings_BH(window5)+window_length)*S_R);

BH_tdft(:,:,window5) = two_D_FT_Gaussian(B(LL5:UL5,1),MF,tr,S_R,size(B,1)/(2*S_R));

end 

for window6 = 1:length(timings_BEE)
    
LL6 = round((timings_BEE(window6)-window_length)*S_R);
UL6 = round((timings_BEE(window6)+window_length)*S_R);

BEE_tdft(:,:,window6) = two_D_FT_Gaussian(A(LL6:UL6,1),MF,tr,S_R,size(A,1)/(2*S_R));

end 

for window7 = 1:length(timings_BGB)
    
LL7 = round((timings_BGB(window7)-window_length)*S_R);
UL7 = round((timings_BGB(window7)+window_length)*S_R);

BGB_tdft(:,:,window7) = two_D_FT_Gaussian(B(LL7:UL7,1),MF,tr,S_R,size(B,1)/(2*S_R));

end 

for window8 = 1:length(timings_BGC)
    
LL8 = round((timings_BGC(window8)-window_length)*S_R);
UL8 = round((timings_BGC(window8)+window_length)*S_R);

BGC_tdft(:,:,window8) = two_D_FT_Gaussian(C(LL8:UL8,1),MF,tr,S_R,size(C,1)/(2*S_R));

end 

for window9 = 1:length(timings_BEE16)
    
LL9 = round((timings_BEE16(window9)-window_length)*S_R);
UL9 = round((timings_BEE16(window9)+window_length)*S_R);

BEE16_tdft(:,:,window9) = two_D_FT_Gaussian(E(LL9:UL9,1),MF,tr,S_R,size(E,1)/(2*S_R));

end 

for window10 = 1:length(timings_BGE)
    
LL10 = round((timings_BGE(window10)-window_length)*S_R);
UL10 = round((timings_BGE(window10)+window_length)*S_R);

BGE_tdft(:,:,window10) = two_D_FT_Gaussian(E(LL10:UL10,1),MF,tr,S_R,size(E,1)/(2*S_R));

end 

% CHECK THE 2DFTS ARE THE RIGHT PARAMETERS:
figure(1)
imagesc([0 0.5*MF/tr], [0 S_R/2], log10(BEE16_tdft(:,:,30)), [max(max(max(log10((1/5000)*(BEE16_tdft))))) max(max(max(log10(BEE16_tdft))))])
axis([0 50 0 1500])
colorbar
h = colorbar;
set(get(h,'label'),'string','Acceleration magnitude (m/s^2)');
colormap jet
xlabel('Spectral repetition (Hz)')
ylabel('Frequency (Hz)')

CR_IHND = IHND_tdft(4:60,:,:);
CR_IHD = IHD_tdft(4:60,:,:);
CR_RHD1 = RHD1_tdft(4:60,:,:);
CR_RHD2 = RHD2_tdft(4:60,:,:);
CR_BH = BH_tdft(4:60,:,:);
CR_BEE = BEE_tdft(4:60,:,:);
CR_BEE16 = BEE16_tdft(4:60,:,:);
CR_BGB = BGB_tdft(4:60,:,:);
CR_BGC = BGC_tdft(4:60,:,:);
CR_BGE = BGE_tdft(4:60,:,:);


for counter = 1:size(IHND_tdft,3)
    IHND_mag = max(IHND_tdft(:,1,counter)); 
    
    new_matrix(:,:,counter) = IHND_mag; 
end 
scaled_IHND = CR_IHND./new_matrix;

for counter = 1:size(IHD_tdft,3)
    IHD_mag = max(IHD_tdft(:,1,counter)); 
    
    new_matrix2(:,:,counter) = IHD_mag; 
end 
scaled_IHD = CR_IHD./new_matrix2;

for counter = 1:size(RHD1_tdft,3)
    RHD1_mag = max(RHD1_tdft(:,1,counter)); 
    
    new_matrix3(:,:,counter) = RHD1_mag; 
end 
scaled_RHD1 = CR_RHD1./new_matrix3;

for counter = 1:size(RHD2_tdft,3)
    RHD2_mag = max(RHD2_tdft(:,1,counter)); 
    
    new_matrix4(:,:,counter) = RHD2_mag; 
end 
scaled_RHD2 = CR_RHD2./new_matrix4;
scaled_hornet = cat(3, scaled_IHND, scaled_IHD, scaled_RHD1, scaled_RHD2);

for counter = 1:size(BH_tdft,3)
    BH_mag = max(BH_tdft(:,1,counter)); 
    
    new_matrix5(:,:,counter) = BH_mag; 
end 
scaled_BH = CR_BH./new_matrix5;

for counter = 1:size(BEE_tdft,3)
    BEE_mag = max(BEE_tdft(:,1,counter)); 
    
    new_matrix6(:,:,counter) = BEE_mag; 
end 
scaled_BEE = CR_BEE./new_matrix6;

for counter = 1:size(BEE16_tdft,3)
    BEE16_mag = max(BEE16_tdft(:,1,counter)); 
    
    new_matrix7(:,:,counter) = BEE16_mag; 
end 
scaled_BEE16 = CR_BEE16./new_matrix7;
scaled_bee = cat(3, scaled_BH, scaled_BEE, scaled_BEE16);

for counter = 1:size(BGB_tdft,3)
    BGB_mag = max(BGB_tdft(:,1,counter)); 
    
    new_matrix8(:,:,counter) = BGB_mag; 
end 
scaled_BGB = CR_BGB./new_matrix8;

for counter = 1:size(BGC_tdft,3)
    BGC_mag = max(BGC_tdft(:,1,counter)); 
    
    new_matrix9(:,:,counter) = BGC_mag; 
end 
scaled_BGC = CR_BGC./new_matrix9;
scaled_BG = cat(3, scaled_BGB, scaled_BGC);

for counter = 1:size(BGE_tdft,3)
    BGE_mag = max(BGE_tdft(:,1,counter)); 
    
    new_matrix10(:,:,counter) = BGE_mag; 
end 
scaled_BGE = CR_BGE./new_matrix10;

%save fourth_TDB.mat


