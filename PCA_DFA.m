clear all 
close all

load fourth_TDB.mat
path(path,'C:\Users\PHY3HALLH\OneDrive - Nottingham Trent University\Desktop\Harriet_matlab_code\useful_matlab_function')

tr = 0.04;
mf = 4;

hornet_array = [];
for counter = 1:size(scaled_hornet,3)
temp = scaled_hornet(:,:,counter);
hornet_array(:,end+1) = temp(:);
end 

hornet_array = hornet_array';

bee_array = [];
for counter = 1:size(scaled_bee,3)
temp = scaled_bee(:,:,counter);
bee_array(:,end+1) = temp(:);
end 

bee_array = bee_array';

BG_array = [];
for counter = 1:size(scaled_BG,3)
temp = scaled_BG(:,:,counter);
BG_array(:,end+1) = temp(:);
end 

BG_array = BG_array';

summerBG_array = [];
for counter = 1:size(scaled_BGE,3)
temp = scaled_BGE(:,:,counter);
summerBG_array(:,end+1) = temp(:);
end 

summerBG_array = summerBG_array';

TDB = [hornet_array; bee_array; BG_array; summerBG_array];

figure(1)
imagesc(log10(abs(TDB)), [max(log10((1/300)*TDB(:))) max(log10(TDB(:)))])
title('\fontsize{20} Training database for bee & hornet discrimination')
xlabel('\fontsize{20} Data points per pulse')
ylabel('\fontsize{20} Pulse number')
colormap jet
colorbar
h = colorbar;
set(get(h,'label'),'string','\fontsize{20} Acceleration magnitude (m/s^2)');
set(gcf,'color','w');
a = get(gca,'TickLabel');  
set(gca,'TickLabel',a,'fontsize',20)

hornet_wavs = size(scaled_hornet,3);
bee_wavs = size(scaled_bee,3);
bg_wavs = size(scaled_BG,3);
bgs_wavs = size(scaled_BGE,3);

% undertake PCA of the collection of 2dfts:
temp2 = mean(TDB);
centred_data_set2 = (TDB - ones(size(TDB,1),1)*temp2)';
L = centred_data_set2*centred_data_set2'; 
[V D] = eig(L);
scores = flipud(V'*centred_data_set2);
Eigenspectra = fliplr(V);

figure(2)
plot(scores(1,1:hornet_wavs),scores(2,1:hornet_wavs),'ro','MarkerFaceColor','r')
hold on
plot(scores(1,(hornet_wavs+1):(hornet_wavs+bee_wavs)),scores(2,(hornet_wavs+1):(hornet_wavs+bee_wavs)),'bo','MarkerFaceColor','b')
hold on
plot(scores(1,(hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs)), scores(2,(hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs)),'ko','MarkerFaceColor','k')
hold on
plot(scores(1,(hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs)), scores(2,(hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs)),'co','MarkerFaceColor','c')

limit = 9;

[U,V, eigenval] = dfa([scores(1:limit,:)]',[zeros(1,hornet_wavs) ones(1,bee_wavs) 2*ones(1,bg_wavs) 3*ones(1,bgs_wavs)],2);

DFA_spectrum_01 = sum(Eigenspectra(:,1:limit)'.*(V(:,1)*ones(1,size(Eigenspectra,2))));
DFA_spectrum_02 = sum(Eigenspectra(:,1:limit)'.*(V(:,2)*ones(1,size(Eigenspectra,2))));
validation_data = TDB;
A_x = sum((validation_data).*(ones(size(validation_data,1),1)*DFA_spectrum_01),2);
A_y = sum((validation_data).*(ones(size(validation_data,1),1)*DFA_spectrum_02),2);

new_dfa = reshape(DFA_spectrum_01, size(scaled_hornet,1), size(scaled_hornet,2));
new_dfa2 = reshape(DFA_spectrum_02, size(scaled_hornet,1), size(scaled_hornet,2));

figure(3)
plot(A_x(1:hornet_wavs),A_y(1:hornet_wavs),'ro','MarkerFaceColor','r')
centroid_01 = [mean(A_x(1:hornet_wavs)) mean(A_y(1:hornet_wavs))];
hold on
plot(A_x((hornet_wavs+1):(hornet_wavs+bee_wavs)),A_y((hornet_wavs+1):(hornet_wavs+bee_wavs)),'bo','MarkerFaceColor','b')
centroid_02 = [mean(A_x((hornet_wavs+1):(hornet_wavs+bee_wavs))) mean(A_y((hornet_wavs+1):(hornet_wavs+bee_wavs)))];
hold on
plot(A_x((hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs)),A_y((hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs)),'ko','MarkerFaceColor','k')
centroid_03 = [mean(A_x((hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs))) mean(A_y((hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs)))];
hold on
plot(A_x((hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs)),A_y((hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs)),'co','MarkerFaceColor','c')
centroid_04 = [mean(A_x((hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs))) mean(A_y((hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs)))];
plot((centroid_01(:,1)), (centroid_01(:,2)), 'yo','markersize', 20, 'Linewidth', 3)
hold on
plot((centroid_02(:,1)), (centroid_02(:,2)), 'go', 'markersize', 20, 'Linewidth', 3)
hold on
plot((centroid_03(:,1)), (centroid_03(:,2)), 'mo', 'markersize', 20, 'Linewidth', 3)
hold on
plot((centroid_04(:,1)), (centroid_04(:,2)), 'ko', 'markersize', 20, 'Linewidth', 3)
xlabel('\fontsize{20} DF score 1')
ylabel('\fontsize{20} DF score 2')
title('\fontsize{20} DFA  outcome (scatterplot)')
a = get(gca,'TickLabel');  
set(gca,'TickLabel',a,'fontsize',20)
legend('hornet','bee','winter background','summer background','Location', 'northwest')

figure(4)
subplot(1,2,1)
imagesc([0 49], [0 1500], log10(abs(new_dfa)),[max(log10((1/300)*abs(new_dfa(:)))) max(log10(abs(new_dfa(:))))])
colormap jet
colorbar
h = colorbar;
set(get(h,'label'),'string','Acceleration magnitude (a.u.)');
title('\fontsize{20} b) DF spectrum 1')
xlabel('\fontsize{20} Spectral Repetition (Hz)')
ylabel('\fontsize{20} Frequency (Hz)')
set(gcf,'color','w');
a = get(gca,'TickLabel');  
set(gca,'TickLabel',a,'fontsize',20)

subplot(1,2,2)
imagesc([0 49], [0 1500], log10(abs(new_dfa2)),[max(log10((1/300)*abs(new_dfa2(:)))) max(log10(abs(new_dfa2(:))))])
colormap jet
colorbar
h = colorbar;
set(get(h,'label'),'string','Acceleration magnitude (a.u.)');
title('\fontsize{20} c) DF spectrum 2')
xlabel('\fontsize{20} Spectral Repetition (Hz)')
ylabel('\fontsize{20} Frequency (Hz)')
set(gcf,'color','w');
a = get(gca,'TickLabel');  
set(gca,'TickLabel',a,'fontsize',20)


% FIGURE FOR MANUSCRIPT

figure(5)
figure('position', [1 1 1920 1080])
subplot(2,1,1)
plot(A_x(1:hornet_wavs),A_y(1:hornet_wavs),'ro','MarkerFaceColor','r')
centroid_01 = [mean(A_x(1:hornet_wavs)) mean(A_y(1:hornet_wavs))];
hold on
plot(A_x((hornet_wavs+1):(hornet_wavs+bee_wavs)),A_y((hornet_wavs+1):(hornet_wavs+bee_wavs)),'bo','MarkerFaceColor','b')
centroid_02 = [mean(A_x((hornet_wavs+1):(hornet_wavs+bee_wavs))) mean(A_y((hornet_wavs+1):(hornet_wavs+bee_wavs)))];
hold on
plot(A_x((hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs)),A_y((hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs)),'ko','MarkerFaceColor','k')
centroid_03 = [mean(A_x((hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs))) mean(A_y((hornet_wavs+bee_wavs+1):(hornet_wavs+bee_wavs+bg_wavs)))];
hold on
plot(A_x((hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs)),A_y((hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs)),'co','MarkerFaceColor','c')
centroid_04 = [mean(A_x((hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs))) mean(A_y((hornet_wavs+bee_wavs+bg_wavs+1):(hornet_wavs+bee_wavs+bg_wavs+bgs_wavs)))];
plot((centroid_01(:,1)), (centroid_01(:,2)), 'yo','markersize', 20, 'Linewidth', 3)
hold on
plot((centroid_02(:,1)), (centroid_02(:,2)), 'go', 'markersize', 20, 'Linewidth', 3)
hold on
plot((centroid_03(:,1)), (centroid_03(:,2)), 'mo', 'markersize', 20, 'Linewidth', 3)
hold on
plot((centroid_04(:,1)), (centroid_04(:,2)), 'ko', 'markersize', 20, 'Linewidth', 3)
xlabel('\fontsize{20} DF score 1')
ylabel('\fontsize{20} DF score 2')
title('\fontsize{20} a) DFA outcome (scatterplot)')
a = get(gca,'TickLabel');  
set(gca,'TickLabel',a,'fontsize',20)
legend('hornet','bee','winter background','summer background','Location', 'northwest')
grid on
%axis([-2 2 -0.33 1.209])
axis equal
axis([-2.5 2.5 -0.33 1.209])

subplot(2,2,3)
%imagesc([0 49], [0 1500], log10(abs(new_dfa)),[max(log10((1/500)*abs(new_dfa(:)))) max(log10(abs(new_dfa(:))))])
imagesc([0 49], [0 1500], (abs(new_dfa)),[max(((1/500)*abs(new_dfa(:)))) max((abs(new_dfa(:))))])
colormap jet
colorbar
h = colorbar;
set(get(h,'label'),'string','Sound Pressure Level (a.u.)');
set(h,'XTick',[0.0001 0.001 0.01 0.1])
title('\fontsize{20} b) DF spectrum 1')
xlabel('\fontsize{20} Spectral Repetition (Hz)')
ylabel('\fontsize{20} Frequency (Hz)')
set(gcf,'color','w');
a = get(gca,'TickLabel');  
set(gca,'TickLabel',a,'fontsize',20)
set(gca,'ColorScale','log')

subplot(2,2,4)
%imagesc([0 49], [0 1500], log10(abs(new_dfa2)),[max(log10((1/500)*abs(new_dfa2(:)))) max(log10(abs(new_dfa2(:))))])
imagesc([0 49], [0 1500], (abs(new_dfa2)),[max(((1/500)*abs(new_dfa2(:)))) max((abs(new_dfa2(:))))])
colormap jet
colorbar
h = colorbar;
set(get(h,'label'),'string','Sound Pressure Level (a.u.)');
set(h,'XTick',[0.0001 0.001 0.01 0.1])
title('\fontsize{20} c) DF spectrum 2')
xlabel('\fontsize{20} Spectral Repetition (Hz)')
ylabel('\fontsize{20} Frequency (Hz)')
set(gcf,'color','w');
a = get(gca,'TickLabel');  
set(gca,'TickLabel',a,'fontsize',20)
set(gca,'ColorScale','log')

decay_curve = mean(abs(scores)');
PCA_deviations(decay_curve,6)

%print('Figure PCA DFA.tif', '-dtiff', '-r400')

%save('masking_parameters.mat','new_dfa','new_dfa2','mf','tr','centroid_01','centroid_02','centroid_03','centroid_04','A_x','A_y')


