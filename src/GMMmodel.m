Nomfccs=14;
Nbands=24;
Framesize=20;FrameShift=10;
Del=0;DelDel=0;NDL=2;
dim=13;
csize=16;iter=50;

% Training

mfcc = zeros(0,14);
nmfcc = zeros(0,14);

i = 1
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\abishek.wav');
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:405*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccAll = mfcc1;

stpt = [4.11 6.86 8.19 17.65 17.93 22.93 34.05 39.14 44.66 44.95 48.47 51.22 55.70 56.04 56.20... 
    68.45 70.95 72.01 72.25 76.02 77.61 85.54 99.49 100.45 102.43 105.39 113.29 117.55 119.87...
    125.71 127.02 135.19 136.24 141.88 143.90 144.53 147.81 149.66 154.44 156.11 157.68 158.98...
    162.44 163.47 168.26 172.84 175.05 187.11 189.89 195.06 196.64 197.03 201.45 215.70 216.32...
	219.59 221.35 222.20 229.38 232.46 233.63 236.09 244.49 250.39 253.83 260.51 261.54 261.88...
	263.51 265.53 266.44 275.60 278.34 279.41 286.85 289.65 291.09 294.83 296.30 298.98 300.56...
	300.88 301.21 302.35 306.66 308.57 311.49 311.66 314.60 316.03 317.13 319.26 321.78 322.50...
	327.27 327.43 328.10 330.02 330.68 331.39 333.95 335.68 336.04 337.54 342.73 344.90 352.18...
	358.94 360.63 361.71 368.32 368.48 370.17 371.61 375.63 375.79 376.40 378.75 382.99 383.42...
	385.63 386.18 389.16 391.49 392.01 392.14 396.17 398.23 398.72 404.84]; 
endpt = [4.16 6.94 8.25 17.68 17.96 22.97 34.09 39.20 44.72 45.02 48.52 51.29 55.74 56.11 56.26...
    68.49 71.02 72.07 72.28 76.09 77.63 85.58 99.52 100.53 102.49 105.43 113.32 117.63 119.96...
    125.78 127.05 135.24 136.32 141.94 143.93 144.56 147.85 149.69 154.47 156.14 157.71 158.02...
    162.49 163.54 168.33 172.92 175.09 187.17 189.92 195.09 196.70 197.10 201.49 215.74 216.39...
    219.68 221.39 222.27 229.41 232.50 233.66 236.11 244.52 250.43 253.86 260.57 261.61 261.91...
	263.53 265.56 266.50 275.62 278.39 279.43 286.94 289.70 291.18 294.88 296.32 299.05 300.62...
	300.93 301.25 302.42 306.70 308.60 311.53 311.69 314.65 316.09 317.18 319.35 321.81 322.53...
	327.30 327.47 328.15 330.05 330.72 331.42 333.99 335.72 336.10 337.57 342.75 344.96 352.21...
	359.01 360.69 361.77 368.37 368.51 370.20 371.68 375.67 375.82 376.44 378.78 383.03 383.45...
	385.69 386.22 389.27 391.52 392.06 392.19 396.21 398.26 398.79 404.89];

bl1 = (stpt+endpt)/2;

stfrno = stpt/.01 + 1;
stfrno = [1 stfrno length(mfcc1)+1];
endfrno = endpt/.01 - 1;
endfrno = [0 endfrno];

for l = 2:(length(stfrno)-1)
    l/(length(endfrno))
    mfcc = [mfcc; mfcc1(round(stfrno(l)):round(endfrno(l)),:)];
    nmfcc = [nmfcc; mfcc1(round(endfrno(l-1)+1):round(stfrno(l)-1),:)];
end
nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):round(stfrno(l+1)-1),:)];
        
        
%{
i = 2
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\anurag.wav');
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:60*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
mfccAll = [mfccAll; mfcc1];

stpt = [4.27 5.22 5.42 7.90 8.13 9.73 11.49 12.00 16.50 22.52 28.52 30.18 31.05 31.80 32.03 32.77 42.28 51.28 52.02 59.23];
endpt = [4.32 5.27 5.46 7.94 8.18 9.78 11.54 12.06 16.56 22.58 28.55 30.30 30.10 31.88 32.08 32.83 42.34 51.32 52.07 59.27];
stfrno = stpt/.01 + ones(size(stpt));
stfrno = [1 stfrno length(mfcc1)+1];
endfrno = endpt/.01 - ones(size(endpt));
endfrno = [0 endfrno];

for l = 2:(length(stfrno)-1)
    l/(length(endfrno))
    mfcc = [mfcc; mfcc1(round(stfrno(l)):round(endfrno(l)),:)];
    nmfcc = [nmfcc; mfcc1(round(endfrno(l-1)+1):round(stfrno(l)-1),:)];
end
nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):round(stfrno(l+1)-1),:)];
%}

i = 3
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\arjya.wav');
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:231*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccAll = [mfccAll; mfcc1];

stpt = [7.05 10.78 11.07 13.24 15.99 16.76 18.26 19.04 19.46 19.77 21.45 21.83 23.65 24.18 26.57 29.67 29.92 31.63 35.80 38.38...
		41.09 41.31 42.42 42.72 43.60 46.88 49.27 51.27 52.77 54.91 55.78 56.45 58.88 62.49 64.76 67.59 74.17 81.40 84.55 93.13...
		98.35 106.48 111.23 113.86 115.68 119.78 123.08 123.76 125.09 128.38 133.34 133.50 134.44 137.22 137.62 140.47 141.57 142.56...
		147.31 149.99 153.93 155.97 163.26 165.74 165.89 168.38 173.63 175.55 178.72 179.82 183.77 184.14 186.54 186.94 191.67 192.07...
		194.68 211.48 213.99 219.71 225.70 230.74];  
endpt = [7.12 10.83 11.13 13.29 16.04 16.80 18.33 19.08 19.50 19.82 21.50 21.88 23.69 24.30 26.61 29.71 29.95 31.68 35.86 38.42...
		41.14 41.36 42.48 42.76 43.66 46.91 49.32 51.30 52.82 54.94 55.88 56.49 58.92 62.51 64.81 67.64 74.22 81.48 84.59 93.22...
		98.38 106.51 111.27 113.92 115.71 119.83 123.11 123.79 125.15 128.34 133.44 133.53 134.47 137.30 137.64 140.56 141.64 142.61...
		147.37 150.05 153.98 155.99 163.32 165.80 165.92 168.42 173.71 175.58 178.74 179.87 183.84 184.21 186.59 187.01 191.75 192.11...
		194.71 211.53 214.05 219.76 225.76 230.80];
bl3 = (stpt+endpt)/2;
stfrno = stpt/.01 + ones(size(stpt));
stfrno = [1 stfrno length(mfcc1)+1];
endfrno = endpt/.01 - ones(size(endpt));
endfrno = [0 endfrno];

for l = 2:(length(stfrno)-1)
    l/(length(endfrno))
    mfcc = [mfcc; mfcc1(round(stfrno(l)):round(endfrno(l)),:)];
    nmfcc = [nmfcc; mfcc1(round(endfrno(l-1)+1):round(stfrno(l)-1),:)];
end
nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):round(stfrno(l+1)-1),:)];


i = 4
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\arkadeep.wav');
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:165*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccAll = [mfccAll; mfcc1];

stpt = [5.64 7.65 7.77 11.23 11.44 14.28 20.97 22.62 24.73 24.95 28.27 30.37 30.48 36.97 39.92 40.56 43.22 45.01 48.70 50.95 51.19 52.07 55.78...
		56.47 56.69 57.12 58.88 61.06 66.55 67.12 70.64 72.12 72.94 74.63 77.30 78.26 81.12 81.88 81.99 85.62 85.71 89.09 89.49 89.76 91.73 93.19...
		93.30 94.07 97.43 97.80 102.42 106.65 107.06 108.12 108.68 110.50 115.31 116.58 117.04 119.69 120.66 121.78 127.05 137.27 140.74 144.83...
		145.68 146.75 147.61 150.32 151.51 153.63 154.53 155.34 156.04 157.84 161.51 164.27];
endpt = [5.69 7.70 7.81 11.27 11.49 14.32 21.07 22.79 24.85 25.00 28.30 30.41 30.54 37.00 39.95 40.63 43.25 45.05 48.73 51.07 51.25 52.16 55.84...
		56.58 56.74 57.15 58.91 61.12 66.64 67.23 70.69 72.18 72.99 74.77 77.37 78.35 81.18 81.94 82.07 85.66 85.78 89.15 89.54 89.80 91.78 93.24...
		93.33 94.14 97.46 97.84 102.46 106.80 107.10 108.16 108.72 110.57 115.36 116.62 117.09 119.75 120.70 121.81 127.10 137.30 140.78 144.90...
		145.76 146.79 147.64 150.36 151.60 153.69 154.58 155.41 156.08 157.91 161.55 164.35];
    bl4 = (stpt+endpt)/2;
stfrno = stpt/.01 + ones(size(stpt));
stfrno = [1 stfrno length(mfcc1)+1];
endfrno = endpt/.01 - ones(size(endpt));
endfrno = [0 endfrno];

for l = 2:(length(stfrno)-1)
    l/(length(endfrno))
    mfcc = [mfcc; mfcc1(round(stfrno(l)):round(endfrno(l)),:)];
    nmfcc = [nmfcc; mfcc1(round(endfrno(l-1)+1):round(stfrno(l)-1),:)];
end
nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):round(stfrno(l+1)-1),:)];

 
i = 5
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\bibhu.wav');
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:20*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccAll = [mfccAll; mfcc1];

stpt = [5.02 7.27 8.96 17.19];
endpt = [5.09 7.32 9.03 17.23];
stfrno = stpt/.01 + ones(size(stpt));
stfrno = [1 stfrno length(mfcc1)+1];
endfrno = endpt/.01 - ones(size(endpt));
endfrno = [0 endfrno];

for l = 2:(length(stfrno)-1)
    l/(length(endfrno))
    mfcc = [mfcc; mfcc1(round(stfrno(l)):round(endfrno(l)),:)];
    nmfcc = [nmfcc; mfcc1(round(endfrno(l-1)+1):round(stfrno(l)-1),:)];
end
nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):round(stfrno(l+1)-1),:)];


i = 6
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\chandra.wav');
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:60*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccAll = [mfccAll; mfcc1];

stpt = [3.85 7.10 14.73 19.80 20.21 21.77 22.70 24.89 25.44 25.99 28.07 30.09 30.88 31.08 31.41 37.04 41.39 44.55 44.75 46.58 48.02 52.49...
        53.47 57.92 58.14];
endpt = [3.90 7.20 14.84 19.88 20.34 21.80 22.75 24.96 25.49 26.12 28.11 30.13 30.95 31.15 31.49 37.09 41.42 44.62 44.79 46.70 48.10 52.53...
        53.57 58.01 58.21];
    bl6 = (stpt+endpt)/2;
stfrno = stpt/.01 + ones(size(stpt));
stfrno = [1 stfrno length(mfcc1)+1];
endfrno = endpt/.01 - ones(size(endpt));
endfrno = [0 endfrno];

for l = 2:(length(stfrno)-1)
    l/(length(endfrno))
    mfcc = [mfcc; mfcc1(round(stfrno(l)):round(endfrno(l)),:)];
    nmfcc = [nmfcc; mfcc1(round(endfrno(l-1)+1):round(stfrno(l)-1),:)];
end
nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):round(stfrno(l+1)-1),:)];


i = 7
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\chanukya.wav');
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:60*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccAll = [mfccAll; mfcc1];

stpt = [2.94 7.80 9.92 12.06 13.19 13.73 20.08 20.92 23.89 25.39 27.11 30.23 30.52 31.27 34.57 36.58 43.92 45.75 47.44];
endpt = [2.98 7.85 10.00 12.14 13.28 13.82 20.12 20.98 23.92 25.45 27.14 30.27 30.59 31.38 34.67 36.70 44.01 45.79 47.50];
bl7 = (stpt+endpt)/2;
stfrno = stpt/.01 + ones(size(stpt));
stfrno = [1 stfrno length(mfcc1)+1];
endfrno = endpt/.01 - ones(size(endpt));
endfrno = [0 endfrno];

for l = 2:(length(stfrno)-1)
    l/(length(endfrno))
    mfcc = [mfcc; mfcc1(round(stfrno(l)):round(endfrno(l)),:)];
    nmfcc = [nmfcc; mfcc1(round(endfrno(l-1)+1):round(stfrno(l)-1),:)];
end
nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):round(stfrno(l+1)-1),:)];


mfcc = mfcc(:,2:14);
nmfcc = nmfcc(:,2:14);
% mfccAll = mfccAll(:,2:14);
% 
% mu = mean(mfccAll); sigma = std(mfccAll);
% 
% mmu = mean(mfcc); msigma = std(mfcc);
% nmu = mean(nmfcc); nsigma = std(nmfcc);
% 
% means = repmat(mmu, size(mfcc,1), 1); sigmas = repmat(msigma, size(mfcc,1), 1);
% nmeans = repmat(nmu, size(nmfcc,1), 1); nsigmas = repmat(nsigma, size(nmfcc,1), 1); 
% mfcc = (mfcc - means)./sigmas;
% nmfcc = (nmfcc - nmeans)./nsigmas;

%%

lcMIX = gmm(dim,csize,'diag');
options = foptions;
options(14) = 5;
lcMIX = gmminit(lcMIX,mfcc,options);
options = zeros(1,18);
options(1) = 0;
options(14) = iter;
[lcMIX options errlog] = gmmem(lcMIX,mfcc,options);

nlcMIX = gmm(dim,csize,'diag');
options = foptions;
options(14) = 5;
nlcMIX = gmminit(nlcMIX,nmfcc,options);
options = zeros(1,18);
options(1) = 0;
options(14) = iter;
[nlcMIX options errlog] = gmmem(nlcMIX,nmfcc,options);

% Save gmmdata.mat

% [U, S] = pca(mfcc);
% Z3 = projectData(mfcc, U, 3);
% figure, plot3(Z3(:,1), Z3(:,2), Z3(:,3))
% grid on;

% [nU, nS] = pca(nmfcc);
% nZ3 = projectData(nmfcc, nU, 3);
% figure, plot3(nZ3(:,1), nZ3(:,2), nZ3(:,3))
% grid on;

%% TESTING

%% TEST1: Test speech sample belongs to training data

[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\chandra.wav');
mfcctest = mfcc_rasta_delta_pkm_v1(speech(1:60*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
mfcctest = mfcctest(:,2:14);

count = 1;
for i = .01:.01:(60-.4)
    i/(60-.4)
    mfccfr = mfcctest(round((i/.01)+1):round(((i+.03)/.01)-1),:);   
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count+1;
end

class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;

fig = figure('Name', 'chandra(1:60)'); plot(classbymaxp);
set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[0:1:60]);
for i = 1:length(bl6)
    line([round(bl6(i)/.01+1) round(bl6(i)/.01+1)], yL, 'color', 'r');
end
line(xL, [0 0], 'color', 'black', 'LineWidth', 2);

%%
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\abishek.wav');
mfcctest = mfcc_rasta_delta_pkm_v1(speech(1:406*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
mfcctest = mfcctest(:,2:14);

stpt = [4.11 6.86 8.19 17.65 17.93 22.93 34.05 39.14 44.66 44.95 48.47 51.22 55.70 56.04 56.20... 
    68.45 70.95 72.01 72.25 76.02 77.61 85.54 99.49 100.45 102.43 105.39 113.29 117.55 119.87...
    125.71 127.02 135.19 136.24 141.88 143.90 144.53 147.81 149.66 154.44 156.11 157.68 158.98...
    162.44 163.47 168.26 172.84 175.05 187.11 189.89 195.06 196.64 197.03 201.45 215.70 216.32...
	219.59 221.35 222.20 229.38 232.46 233.63 236.09 244.49 250.39 253.83 260.51 261.54 261.88...
	263.51 265.53 266.44 275.60 278.34 279.41 286.85 289.65 291.09 294.83 296.30 298.98 300.56...
	300.88 301.21 302.35 306.66 308.57 311.49 311.66 314.60 316.03 317.13 319.26 321.78 322.50...
	327.27 327.43 328.10 330.02 330.68 331.39 333.95 335.68 336.04 337.54 342.73 344.90 352.18...
	358.94 360.63 361.71 368.32 368.48 370.17 371.61 375.63 375.79 376.40 378.75 382.99 383.42...
	385.63 386.18 389.16 391.49 392.01 392.14 396.17 398.23 398.72 404.84]; 

count = 1;
for j = 0:.01:(60-.01)
    j/405
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);    
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
cmp = [classbymaxp]; %Matrix to concatenate all classbymax matrices
% fig = figure('Name', 'abishek(1:60)'); plot(classbymaxp); hold on
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
% xL = get(gca, 'XLim');
% yL = get(gca, 'YLim');
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[0:1:60]);
% for i = 1:length(stpt)
%     if stpt(i)>60 break; end;
%     line([round(stpt(i)/.01+1) round(stpt(i)/.01+1)], yL, 'color', 'r');
% end
% line(xL, [0 0], 'color', 'black', 'LineWidth', 2);
% [~, peakdetect] = findpeaks(classbymaxp);
% plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');

count = 1;
for j = 60:.01:(120-.01)
    j/405
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);    
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
cmp = [cmp classbymaxp];
% fig = figure('Name', 'abishek(60:120)'), plot(classbymaxp); hold on
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
% xL = get(gca, 'XLim');
% yL = get(gca, 'YLim');
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[60:1:120]);
% for i = i:length(stpt)
%     if stpt(i)>120 break; end;
%     line([round((stpt(i)-60)/.01+1) round((stpt(i)-60)/.01+1)], yL, 'color', 'r');
% end
% line(xL, [0 0], 'color', 'black', 'LineWidth', 2);
% [~, peakdetect] = findpeaks(classbymaxp);
% plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');


% TO DEMONSTRATE USING prob & prob-nprob
% probp = prob - min(prob);
% probp = probp/max(probp);
% probp = probp - .9;
% probp(probp<0) = 0;
% probp = probp/max(probp);
% probp = probp - .3;
% probp(probp<0) = 0;
% probp = probp/max(probp);
% cbmp = classbymaxp - .3;
% cbmp(cbmp<0) = 0;
% cbmp = cbmp/max(cbmp);
% figure, plot(probp, 'linewidth', 1.5); hold on
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[60:1:120]);
% line([round((100.45-60)/.01+1) round((100.45-60)/.01+1)], yL, 'color', 'r', 'linewidth', 2);
% line([round((99.49-60)/.01+1) round((99.49-60)/.01+1)], yL, 'color', 'r', 'linewidth', 2);
% [~, peakdetect] = findpeaks(probp);
% plot(peakdetect, probp(peakdetect), '*', 'color', 'k', 'markersize', 10);
% figure, plot(cbmp, 'linewidth', 1.5); hold on
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[60:1:120]);
% line([round((100.45-60)/.01+1) round((100.45-60)/.01+1)], yL, 'color', 'r', 'linewidth', 2);
% line([round((99.49-60)/.01+1) round((99.49-60)/.01+1)], yL, 'color', 'r', 'linewidth', 2);
% [~, peakdetect] = findpeaks(cbmp);
% plot(peakdetect, cbmp(peakdetect), '*', 'color', 'k', 'markersize', 10);

count = 1;
for j = 120:.01:(180-.01)
    j/405
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
cmp = [cmp classbymaxp];
% fig = figure('Name', 'abishek(120:180)'), plot(classbymaxp); hold on
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
% xL = get(gca, 'XLim');
% yL = get(gca, 'YLim');
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[120:1:180]);
% for i = i:length(stpt)
%     if stpt(i)>180 break; end;
%     line([round((stpt(i)-120)/.01+1) round((stpt(i)-120)/.01+1)], yL, 'color', 'r');
% end
% line(xL, [0 0], 'color', 'black', 'LineWidth', 2);
% [~, peakdetect] = findpeaks(classbymaxp);
% plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');

count = 1;
for j = 180:.01:(240-.01)
    j/405
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
cmp = [cmp classbymaxp];
% fig = figure('Name', 'abishek(180:240)'), plot(classbymaxp); hold on
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
% xL = get(gca, 'XLim');
% yL = get(gca, 'YLim');
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[180:1:240]);
% for i = i:length(stpt)
%     if stpt(i)>240 break; end;
%     line([round((stpt(i)-180)/.01+1) round((stpt(i)-180)/.01+1)], yL, 'color', 'r');
% end
% line(xL, [0 0], 'color', 'black', 'LineWidth', 2);
% [~, peakdetect] = findpeaks(classbymaxp);
% plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');

count = 1;
for j = 240:.01:(300-.01)
    j/405
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
cmp = [cmp classbymaxp];
% fig = figure('Name', 'abishek(240:300)'), plot(classbymaxp); hold on
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
% xL = get(gca, 'XLim');
% yL = get(gca, 'YLim');
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[240:1:300]);
% for i = i:length(stpt)
%     if stpt(i)>300 break; end;
%     line([round((stpt(i)-240)/.01+1) round((stpt(i)-240)/.01+1)], yL, 'color', 'r');
% end
% line(xL, [0 0], 'color', 'black', 'LineWidth', 2);
% [~, peakdetect] = findpeaks(classbymaxp);
% plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');

count = 1;
for j = 300:.01:(360-.01)
    j/405
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);    
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr))); 
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
cmp = [cmp classbymaxp];
% fig = figure('Name', 'abishek(300:360)'), plot(classbymaxp); hold on
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
% xL = get(gca, 'XLim');
% yL = get(gca, 'YLim');
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),61), 'XTickLabel',[300:1:360]);
% for i = i:length(stpt)
%     if stpt(i)>360 break; end;
%     line([round((stpt(i)-300)/.01+1) round((stpt(i)-300)/.01+1)], yL, 'color', 'r');
% end
% line(xL, [0 0], 'color', 'black', 'LineWidth', 2);
% [~, peakdetect] = findpeaks(classbymaxp);
% plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');

count = 1;
for j = 360:.01:405
    j/405
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);    
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
cmp = [cmp classbymaxp];
% fig = figure('Name', 'abishek(360:405)'), plot(classbymaxp); hold on
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
% xL = get(gca, 'XLim');
% yL = get(gca, 'YLim');
% set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),46), 'XTickLabel',[360:1:405]);
% for i = i:length(stpt)
%     if stpt(i)>405 break; end;
%     line([round((stpt(i)-360)/.01+1) round((stpt(i)-360)/.01+1)], yL, 'color', 'r');
% end
% line(xL, [0 0], 'color', 'black', 'LineWidth', 2);
% [~, peakdetect] = findpeaks(classbymaxp);
% plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');

da = 99; db = 100;
da = 135; db = 137;
da = 141; db = 145;
da = 154; db = 176;
da = 194; db = 223;
da = 300; db = 360;
da = 360; db = 390;
%d = cmp(da/.01+1:db/.01+1);
count = 1; prob = []; nprob = []; classbymaxp = [];
for j = da:.01:(db-.01)
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);    
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr))); 
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(classbymaxp<0) = 0;
fig = figure('Name', 'd'); plot(classbymaxp, 'linewidth', 1.5); hold on;
set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),db-da+1), 'XTickLabel',da:1:db);
for i = 1:length(stpt)
    if stpt(i)<da continue; end
    if stpt(i)>db break; end
    line([round((stpt(i)-da)/.01+1) round((stpt(i)-da)/.01+1)], yL, 'color', 'r', 'linewidth', 2);
end
[~, peakdetect] = findpeaks(classbymaxp);
plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k', 'markersize', 10);
line(xL, [0 0], 'color', 'k', 'linewidth', 2);
xlabel('Time', 'fontname', 'Arial Black', 'fontsize',18,'fontweight','b');
ylabel('Probability of occurence of bilabial', 'fontname', 'Arial Black', 'fontsize',18,'fontweight','b');
title(strcat(num2str(da), ':', num2str(db)), 'fontname', 'Arial Black', 'fontsize', 18, 'fontweight', 'b');
count = 0;
for i=1:length(peakdetect)
if(sum(abs(stpt-((peakdetect(i)-1)*.01+141))<.01)>=1) count = count+1; end
end


% PLOT CMP
%
% fig = figure('Name', 'cmp'); plot(cmp); hold on;
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
% xL = get(gca, 'XLim');
% yL = get(gca, 'YLim');
% set(gca, 'XTick', linspace(xL(1),xL(2),(xL(2)+1)*.01), 'XTickLabel',[0:1:405]);
% for i = 1:length(stpt)
%     line([round(stpt(i)/.01+1) round(stpt(i)/.01+1)], yL, 'color', 'r');
% end

% Finding the True Positives
count = zeros(1,9);
for threshold = .1:.1:.9
    [~, peakdetect] = findpeaks(cmp, 'MinPeakHeight', threshold, 'MinPeakDistance', 2);
%     plot(peakdetect, b(peakdetect), '*', 'color', 'k');
%     for i = 1:length(stpt)
%         line([round(stpt(i)/.01+1) round(stpt(i)/.01+1)], yL, 'color', 'r');
%     end
    match = zeros(size(peakdetect));
    for i=1:length(peakdetect)
        if(sum(abs(stpt-(peakdetect(i)-1)*.01)<.01)>=1)
            count(round(threshold*10)) = count(round(threshold*10))+1;
            match(i) = 1;
        end
    end
    peaks{round(threshold*10)} = (peakdetect-1)*.01;
    correctpeaks{round(threshold*10)} = (peakdetect-1)*.01.*match;
end

for i=1:9
    fprintf('threshold = %.1f', i*.1);
    correctpeaks{i}(find(peaks{i}>0))
end

%%
[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\chanukya.wav');
mfcctest = mfcc_rasta_delta_pkm_v1(speech(1:31*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
mfcctest = mfcctest(:,2:14);

count = 1;
for j = 0:.01:(30-.01)
    j/(30-.01)
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);    
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count + 1;
end
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
fig = figure('Name', 'chanukya(0:30)'), plot(classbymaxp);
set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),31), 'XTickLabel',[0:1:30]);
for i = 1:length(stpt)
    if stpt(i)>30 break; end;
    line([round(stpt(i)*(xL(2)-xL(1))/30+1) round(stpt(i)*(xL(2)-xL(1))/30+1)], yL, 'color', 'r');
end
line(xL, [0 0], 'color', 'black', 'LineWidth', 2);

%% TEST2: Test speech sample is not within training data

[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\manoj.wav');
mfcctest = mfcc_rasta_delta_pkm_v1(speech(1:31*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
mfcctest = mfcctest(:,2:14);

count = 1;
for i = 0:.01:30
    i/30
    mfccfr = mfcctest(round((i/.01)+1):round(((i+.02)/.01)+1),:);    
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count+1;    
end

stpt = [1.71 2.45 2.70 2.85 3.29 6.41 6.61 7.48 8.08 10.43 10.56 14.93 16.06 16.39 16.76 18.19 21.68 22.88 22.03 23.25 25.04 25.41 28.25];
endpt = [1.74 2.49 2.74 2.89 3.32 6.44 6.68 7.53 8.14 10.48 10.60 15.01 16.13 16.43 16.81 18.24 21.85 22.95 22.08 23.30 25.07 25.44 28.28];
bl = (stpt+endpt)/2;
class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;
fig = figure('Name', 'manoj(0:30)'), plot(classbymaxp);
set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),31), 'XTickLabel',[0:1:30]);
for i = 1:length(stpt)
    if stpt(i)>30 break; end;
    line([round(stpt(i)*(xL(2)-xL(1))/30+1) round(stpt(i)*(xL(2)-xL(1))/30+1)], yL, 'color', 'r');
end
line(xL, [0 0], 'color', 'black', 'LineWidth', 2);


%% Satyamev Jayate vid

% Loading Lip Closure Points from Video
load('C:\Users\Vikram\Documents\EDU\Summer 2012\Vids\sj.dat');
sj = sj/1000; %From msecs to secs

% Loading Video
vid = mmreader('C:\Users\Vikram\Documents\EDU\Summer 2012\Vids\sj.avi');
FS = get(vid, 'FrameRate');

% Estimating prob. of Bilabials in sound file using GMM:

[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\Vids\sj.wav');
speech = mean(speech')';
mfcctest = mfcc_rasta_delta_pkm_v1(speech(1:11*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
mfcctest = mfcctest(:,2:14);

stpt = [.20 .88 2.11 2.52 3.29 5.59 7.86 9.90 10.26];
endpt = [.22 .93 2.13 2.57 3.30 5.67 7.89 9.98 10.27];

count = 1; prob = []; nprob = [];
distVowel = -ones(1000,1);
for j = 0:.01:(10-.01)
    j/10
    mfccfr = mfcctest(round((j/.01)+1):round(((j+.02)/.01)+1),:);    
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count + 1;
    
    % Detecting vowel
    distVowel(round(j*100)+1,:) = vowelDetector(speech((j*fs+1):((j+.128)*fs+1)),fs);
end

    % Detecting VOWELS
    [~, Apeaks] = findpeaks(-distVowel(:,1));
    [~, Epeaks] = findpeaks(-distVowel(:,2));
    [~, Ipeaks] = findpeaks(-distVowel(:,3));
    [~, Opeaks] = findpeaks(-distVowel(:,4));
    [~, Upeaks] = findpeaks(-distVowel(:,5));

    figure(1), plot(0:.01:10,-distVowel(:,1)), hold on, plot(.01*Apeaks, -distVowel(Apeaks,1), '*', 'color', 'k', 'markersize', 5);
    figure(2), plot(0:.01:10,-distVowel(:,2)), hold on, plot(.01*Epeaks, -distVowel(Epeaks,2), '*', 'color', 'k', 'markersize', 5);
    figure(3), plot(0:.01:10,-distVowel(:,3)), hold on, plot(.01*Ipeaks, -distVowel(Ipeaks,3), '*', 'color', 'k', 'markersize', 5);
    figure(4), plot(0:.01:10,-distVowel(:,4)), hold on, plot(.01*Opeaks, -distVowel(Opeaks,4), '*', 'color', 'k', 'markersize', 5);
    figure(5), plot(0:.01:10,-distVowel(:,5)), hold on, plot(.01*Upeaks, -distVowel(Upeaks,5), '*', 'color', 'k', 'markersize', 5);

class = prob - nprob;
classbymax = class/(max(class));
classbymaxp = classbymax;
classbymaxp(class<0) = 0;

divclass = prob./nprob;

% Plotting results:
fig = figure('Name', 'SJ'); plot(classbymaxp, 'linewidth', 1.5); hold on;
set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),21), 'XTickLabel',0:.5:10);
line(xL, [0 0], 'color', 'black', 'LineWidth', 2);
sj1 = sj + .15; sj1(sj1>10) = [];
sj2 = sj1*(xL(2)-xL(1))/10 + 1; %time->samples
[~, peakdetect] = findpeaks(classbymaxp);
plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k', 'markersize', 10);
xL = get(gca, 'xlim');
stem(sj2(:), .5*ones(length(sj2)), '--', 'color', 'k', 'markersize', 5);
for i = 1:length(stpt)
    if(stpt(i)>10) break; end
    line([round(stpt(i)*(xL(2)-xL(1))/10+1) round(stpt(i)*(xL(2)-xL(1))/10+1)], yL, 'color', 'r');
end
%{
%Thresholding 'peakdetect' and plotting
peakdetect(classbymaxp(peakdetect)<.3) = [];
plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k', 'markersize', 10);
peakdetect = (peakdetect(:)-1)*10/(xL(2)-xL(1)); %peakdetect in time
%}

% Eliminating time durations with no speech
[segments, fs, Limits] = detectVoice('C:\Users\Vikram\Documents\EDU\Summer 2012\Vids\sj.wav'); %Limits in frame no.
Limits = (Limits-1)/fs; %Limits in time
peakdetect = (peakdetect(:)-1)*10/(xL(2)-xL(1)); %peakdetect in time
peakdetect(peakdetect<Limits(1,1)) = [];
for i = 1:(size(Limits,1)-1)
    peakdetect(peakdetect>Limits(i,2) & peakdetect<Limits(i+1,1)) = [];
end
peakdetect(peakdetect>Limits(i+1,2)) = [];
plot(round(peakdetect*(xL(2)-xL(1))/10+1), classbymaxp(round(peakdetect*(xL(2)-xL(1))/10+1)), 'o', 'color', 'r');
plot(round(peakdetect*(xL(2)-xL(1))/10+1), classbymaxp(round(peakdetect*(xL(2)-xL(1))/10+1)), 'o', 'color', 'r', 'markersize', 10);


% Eliminating places with no lip movement in the video
sj1(sj1<Limits(1,1)) = [];
for i = 1:(size(Limits,1)-1)
    sj1(sj1>Limits(i,2) & sj1<Limits(i+1,1))  = [];
end
sj1(sj1>Limits(i+1,2)) = [];

count = 1;
i=2;
while i<length(sj1)    
    if(sj1(i)-sj1(i-1)<.1)
        count = 0;
        while(sj1(i)-sj1(i-1)<.1 && i<length(sj1))
            i = i+1;
            count = count+1;
        end
        i = i-1;
        while(count>0)
            sj1(i) = [];
            i = i-1;
            count = count-1;
        end
    end
    i = i+1;
end
sj2 = sj1*(xL(2)-xL(1))/10 + 1; %time->samples
stem(sj2(:), .95*ones(length(sj2)), '--', 'color', 'm', 'linewidth', 2);
stem(sj2(:), .95*ones(length(sj2)), '--', 'color', 'm', 'linewidth', 2, 'markersize', 10);
xlabel('Time', 'fontname', 'Arial Black', 'fontsize',18,'fontweight','b');
ylabel('Probability of occurence of bilabial', 'fontname', 'Arial Black', 'fontsize',18,'fontweight','b');
title('Bilabials from Audio and Video signals', 'fontname', 'Arial Black', 'fontsize', 18, 'fontweight', 'b');


% Plotting points with bilabials detected in video and in audio
figure, stem(stpt(:), ones(length(stpt),1), 'color', 'k');
hold on
xL2 = get(gca, 'xLim');
set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
stem(sj(:), .3*ones(length(sj)), 'color', 'b')
stem(sj2(:), .8*ones(length(sj2)), 'color', 'r');
stem(peakdetect, .5*ones(length(peakdetect)), 'color', 'g');
set(gca, 'XTick', linspace(xL2(1), xL2(2), (xL2(2)-xL2(1))*10+1), 'XTickLabel', xL2(1):.1:xL2(2));

for i=1:length(stpt)
    for j = 1:length(sj)
        
        
        
    end
end

%%
%{
Introduce synthetic offset, measure offset from exp
Vowel Detection to reject bilabials that don't follow vowels

Resons for not working:
- Not enough traning for the GMM
- Only trained bilabials following vowels
- May be a natural delay between lip-closure and bilabial in audio..
- Threshold in GMM

Features:
- Lip Closure Detection using Strip
- Voice Activity detection
- Bialbials are the peaks in the GMM Plot


%precision, recall, f1score
% P = #TP/#TP+~TN
% R = #TP/#TP+#FN
% F1Score = 2PR/(P+R)
%}