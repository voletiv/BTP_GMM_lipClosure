% MATLAB
% Adobe Soundbooth

clear all
clc

Nomfccs=14;
Nbands=24;
Framesize=20;FrameShift=10;
Del=0;DelDel=0;NDL=2;
dim=13;
csize=8; %No. of centres
iter=50;

%% Training

mfcc = [];
nmfcc = [];

% Reading the speech
[speech fs nbits] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\abishek.wav');
%{
% Filtering it to Human Speech frequencies
h1 = [.457 .461 .465 .468 .471 .474 .4765 .478 .479 .48 .48 .48 .479 .478 .4765 .474 .471 .468 .465 .461 .457];
h2 = [0.13170420713091874 0.13197237482359753 0.13213344693153592 0.1321871662345887 0.13213344693153592 0.13197237482359753 0.13170420713091874];
h3 = [.132 .132 .132 .132 .132 .132 .132];
filtspeech1 = filter(h1, 1, speech);
filtspeech2 = filter(h2, 1, speech);
filtspeech3 = filter(h3, 1, speech);

wavwrite(filtspeech1, fs, nbits, 'C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\abishek1.wav');
wavwrite(filtspeech2, fs, nbits, 'C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\abishek2.wav');
wavwrite(filtspeech3, fs, nbits, 'C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\abishek3.wav');

figure, plot(speech(1:40*fs), 'color', 'red'); hold on
plot(filtspeech(1:40*fs));
xL = get(gca, 'XLim');
set(gca, 'XTick', linspace(xL(1), xL(2), 41), 'XTickLabel', 0:40);
%}
% Calculating the mfcc parameters
T = 292;
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:T*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccs = mfcc_rasta_delta_pkm_v1(filtspeech(1:40*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccAll = mfcc1;

stpt = [4.13 39.17 56.25 62.70 63.12 76.07 100.49 117.59 119.91 125.75 135.23 136.25 140.94 ...
    141.81 154.45 162.43 168.25 172.85 173.78 179.33 182.53 187.10 192.33 197.03 200.28 201.43 ...
    216.32 219.58 221.35 222.19 232.47 233.63 234.31 249.33 260.51 261.55 266.45 278.34 286.86 ...
    291.10];
%{
stpt = [4.13 39.17 56.25 62.70 63.12 76.07 100.49 117.59 119.91...
    125.75 135.23 136.24 141.88 143.90 144.53 147.81 149.66 154.44 156.11 157.68 158.98...
    162.44 163.47 168.26 172.84 175.05 187.11 189.89 195.06 196.64 197.03 201.45 215.70 216.32...
	219.59 221.35 222.20 229.38 232.46 233.63 236.09 244.49 250.39 253.83 260.51 261.54 261.88...
	263.51 265.53 266.44 275.60 278.34 279.41 286.85 289.65 291.09 294.83 296.30 298.98 300.56...
	300.88 301.21 302.35 306.66 308.57 311.49 311.66 314.60 316.03 317.13 319.26 321.78 322.50...
	327.27 327.43 328.10 330.02 330.68 331.39 333.95 335.68 336.04 337.54 342.73 344.90 352.18...
	358.94 360.63 361.71 368.32 368.48 370.17 371.61 375.63 375.79 376.40 378.75 382.99 383.42...
	385.63 386.18 389.16 391.49 392.01 392.14 396.17 398.23 398.72 404.84];
%}
endpt = [4.19 39.26 56.29 62.80 63.17 76.13 100.55 117.65 119.94 125.81 135.28 136.35 140.97 ...
    141.93 154.49 162.49 168.33 172.89 173.88 179.36 182.60 187.16 192.38 197.11 200.30 201.49 ...
    216.40 219.66 221.41 222.29 232.51 233.67 234.35 249.36 260.62 261.62 266.51 278.42 286.93 ...
    291.21];
%{
endpt = [4.19 39.26 56.29 62.80 63.17 76.13 100.55 117.65 119.94...
    125.81 135.28 136.32 141.94 143.93 144.56 147.85 149.69 154.47 156.14 157.71 158.02...
    162.49 163.54 168.33 172.92 175.09 187.17 189.92 195.09 196.70 197.10 201.49 215.74 216.39...
    219.68 221.39 222.27 229.41 232.50 233.66 236.11 244.52 250.43 253.86 260.57 261.61 261.91...
	263.53 265.56 266.50 275.62 278.39 279.43 286.94 289.70 291.18 294.88 296.32 299.05 300.62...
	300.93 301.25 302.42 306.70 308.60 311.53 311.69 314.65 316.09 317.18 319.35 321.81 322.53...
	327.30 327.47 328.15 330.05 330.72 331.42 333.99 335.72 336.10 337.57 342.75 344.96 352.21...
	359.01 360.69 361.77 368.37 368.51 370.20 371.68 375.67 375.82 376.44 378.78 383.03 383.45...
	385.69 386.22 389.27 391.52 392.06 392.19 396.21 398.26 398.79 404.89];
%}
bl1 = (stpt+endpt)/2;

stfrno = stpt/.01 + 1;
endfrno = endpt/.01 + 1;

nmfcc = [nmfcc; mfcc1(1:round(stfrno(1)-1),:)];
for l = 1:length(stfrno)
    l/(length(endfrno))
    mfcc = [mfcc; mfcc1(round(stfrno(l)):round(endfrno(l)),:)];
    if(l==length(stfrno)) nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):end,:)];
    else nmfcc = [nmfcc; mfcc1(round(endfrno(l)+1):round(stfrno(l+1)-1),:)];
    end
end


[speech fs] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\arjya.wav');
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:231*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);
%mfccAll = [mfccAll; mfcc1];

stpt = [7.05 10.78 18.24 18.57 21.46 21.83 24.18 31.63 35.83 38.38 41.11 41.31 44.61 49.27 52.77 54.90 55.80 58.38 58.89 62.49 64.76...
        67.59 74.17 81.40 84.55 93.13 98.91 109.37 113.86 119.78 125.09 128.28 133.34 137.62 140.47 141.58 143.15 147.31 150.01 153.93...
        157.27 173.64 175.55 179.82 184.14 187.22 191.67 192.06];
%{  
stpt = [7.05 10.78 11.07 13.24 15.99 16.76 18.26 19.04 19.46 19.77 21.45 21.83 23.65 24.18 26.57 29.67 29.92 31.63 35.80 38.38...
		41.09 41.31 42.42 42.72 43.60 46.88 49.27 51.27 52.77 54.91 55.78 56.45 58.88 62.49 64.76 67.59 74.17 81.40 84.55 93.13...
		98.35 106.48 111.23 113.86 115.68 119.78 123.08 123.76 125.09 128.38 133.34 133.50 134.44 137.22 137.62 140.47 141.57 142.56...
		147.31 149.99 153.93 155.97 163.26 165.74 165.89 168.38 173.63 175.55 178.72 179.82 183.77 184.14 186.54 186.94 191.67 192.07...
		194.68 211.48 213.99 219.71 225.70 230.74];  
%}

endpt = [7.11 10.83 18.33 18.61 21.51 21.88 24.25 31.69 35.88 38.44 41.16 41.37 44.67 49.32 52.83 54.94 55.89 58.44 58.92 62.55 64.81...
        67.65 74.25 81.48 84.59 93.26 98.99 109.43 113.93 119.82 125.14 128.34 133.43 137.67 140.55 141.61 143.19 147.37 150.05 153.99...
        157.34 173.71 175.58 179.88 184.21 187.27 191.74 192.12];
%{
endpt = [7.12 10.83 11.13 13.29 16.04 16.80 18.33 19.08 19.50 19.82 21.50 21.88 23.69 24.30 26.61 29.71 29.95 31.68 35.86 38.42...
		41.14 41.36 42.48 42.76 43.66 46.91 49.32 51.30 52.82 54.94 55.88 56.49 58.92 62.51 64.81 67.64 74.22 81.48 84.59 93.22...
		98.38 106.51 111.27 113.92 115.71 119.83 123.11 123.79 125.15 128.34 133.44 133.53 134.47 137.30 137.64 140.56 141.64 142.61...
		147.37 150.05 153.98 155.99 163.32 165.80 165.92 168.42 173.71 175.58 178.74 179.87 183.84 184.21 186.59 187.01 191.75 192.11...
		194.71 211.53 214.05 219.76 225.76 230.80];
%}
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

stpt = [7.65 7.78 11.23 11.44 11.59 14.28 15.13 15.22 20.97 22.62 24.95 30.39 30.50 31.05 40.59 49.45 50.93 51.19 52.10 55.78...
		56.47 56.69 57.82 61.06 64.18 66.55 66.85 67.13 70.44 70.60 70.77 72.12 74.64 77.31 78.16 78.28 81.12];
%{
stpt = [5.64 24.73 28.27 36.97 39.92 43.22 45.01 48.70 57.12 58.88 72.94 81.88 81.99 85.62 85.71 89.09 89.49 89.76 91.73 93.19...
		93.30 94.07 97.43 97.80 102.42 106.65 107.06 108.12 108.68 110.50 115.31 116.58 117.04 119.69 120.66 121.78 127.05 137.27 140.74 144.83...
		145.68 146.75 147.61 150.32 151.51 153.63 154.53 155.34 156.04 157.84 161.51 164.27];
%}
        
endpt = [7.70 7.81 11.27 11.49 11.65 14.33 15.16 15.28 21.07 22.79 25.00 30.41 30.54 31.15 40.63 49.50 51.00 51.25 52.16 55.84...
		56.54 56.74 57.86 61.12 64.21 66.64 66.89 67.20 70.47 70.67 70.81 72.18 74.73 77.37 78.20 78.34 81.18];
%{
endpt = [5.69 24.85 28.30 37.00 39.95 43.25 45.05 48.73 57.15 58.91 72.99 81.94 82.07 85.66 85.78 89.15 89.54 89.80 91.78 93.24...
		93.33 94.14 97.46 97.84 102.46 106.80 107.10 108.16 108.72 110.57 115.36 116.62 117.09 119.75 120.70 121.81 127.10 137.30 140.78 144.90...
		145.76 146.79 147.64 150.36 151.60 153.69 154.58 155.41 156.08 157.91 161.55 164.35];
%}
    
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

mfcc = mfcc(:,2:14);
nmfcc = nmfcc(:,2:14);

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

%% Test 1: Belongs to training
mfcctest = mfcc1(:,2:14);
count = 1;
for i = 0:.01:T-.05
    i/T
    mfccfr = mfcctest(round((i/.01)+1):round(((i+.03)/.01)+1),:);   
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count+1;
end

class = prob - nprob;
class = class - min(class);
classbymax = class/max(class);
classbymaxp = classbymax - .85;
classbymaxp(classbymaxp<0) = 0;
classbymaxp = classbymaxp/max(classbymaxp);

%figure, plot(prob); figure, plot(nprob);
fig = figure('Name', 'abhisek(0:40)'); plot(classbymaxp); hold on
set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1),xL(2),(xL(2)-xL(1))/100), 'XTickLabel',xL(1)*.01:xL(2)*.01);
for i = 1:length(bl1)
    %line([round(stpt(i)/.01+1) round(stpt(i)/.01+1)], yL, 'color', 'g');
    line([round(bl1(i)/.01+1) round(bl1(i)/.01+1)], yL, 'LineStyle', '--', 'LineWidth', 2, 'color', 'r');
    %line([round(endpt(i)/.01+1) round(endpt(i)/.01+1)], yL, 'color', 'b');
end
line(xL, [0 0], 'color', 'black', 'LineWidth', 2);

%Finding Peaks
[~, peaks] = findpeaks(classbymaxp); %peakdetect in frame no.
%peaks
[~, peaks] = findpeaks(classbymaxp, 'MINPEAKDISTANCE', 20); %peakdetect in frame no.
%peaks

%Thresholding 'peakdetect' and plotting
peakdetect = peaks;
%peakdetect(classbymaxp(peakdetect)<.3) = [];
%figure, plot(classbymaxp); hold on
plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');
peakdetect = (peakdetect(:)-1)*.01; %peakdetect in time

% Eliminating time durations with no speech
[segments, fs, Limits] = detectVoice('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\abishek.wav'); %Limits in frame no.
Limits = (Limits-1)/fs; %Limits in time
peakdetect(peakdetect<Limits(1,1)) = [];
for i = 1:(size(Limits,1)-1)
    peakdetect(peakdetect>Limits(i,2) & peakdetect<Limits(i+1,1)) = [];
end
peakdetect(peakdetect>Limits(i+1,2)) = [];
plot(round(peakdetect/.01+1), classbymaxp(round(peakdetect/.01+1)), 'o', 'color', 'r');


%% Test 2: Something new

[speech fs nbits] = wavread('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\arkadeep.wav');
T = 60;
mfcc1 = [];
mfcc1 = mfcc_rasta_delta_pkm_v1(speech(1:T*fs),fs,Nomfccs,Nbands,Framesize,FrameShift,Del,DelDel,NDL);

mfcctest = [];
mfcctest = mfcc1(:,2:14);

count = 1;
prob = []; nprob = []; class = []; classbymax = []; classbymaxp = []; mfccfr = [];
for i = 0:.01:T-.05
    i/T
    mfccfr = mfcctest(round((i/.01)+1):round(((i+.03)/.01)+1),:);   
    prob(count) = sum(log(gmmprob(lcMIX,mfccfr)));
    nprob(count) = sum(log(gmmprob(nlcMIX,mfccfr)));
    count = count+1;
end

class = prob - nprob;
class = class - min(class);
classbymax = class/max(class);
classbymaxp = classbymax - .85;
classbymaxp(classbymaxp<0) = 0;
classbymaxp = classbymaxp/max(classbymaxp);

%figure, plot(prob); figure, plot(nprob);
fig = figure('Name', 'arkadeep(0:60)'); plot(classbymaxp); hold on
set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
set(gca, 'XGrid', 'on', 'XTick', linspace(xL(1), xL(2),(xL(2)-xL(1))/100), 'XTickLabel', xL(1)*.01:xL(2)*.01);
%{
for i = 1:length(bl1)
    %line([round(stpt(i)/.01+1) round(stpt(i)/.01+1)], yL, 'color', 'g');
    line([round(bl1(i)/.01+1) round(bl1(i)/.01+1)], yL, 'color', 'r');
    %line([round(endpt(i)/.01+1) round(endpt(i)/.01+1)], yL, 'color', 'b');
end
%}
line(xL, [0 0], 'color', 'black', 'LineWidth', 2);

%Finding Peaks
[~, peaks] = findpeaks(classbymaxp); %peakdetect in frame no.
%peaks
[~, peaks] = findpeaks(classbymaxp, 'MINPEAKDISTANCE', 20); %peakdetect in frame no.
%peaks

%Thresholding 'peakdetect' and plotting
peakdetect = peaks;
%peakdetect(classbymaxp(peakdetect)<.3) = [];
%figure, plot(classbymaxp); hold on
plot(peakdetect, classbymaxp(peakdetect), '*', 'color', 'k');
peakdetect = (peakdetect(:)-1)*.01; %peakdetect in time

% Eliminating time durations with no speech
[segments, fs, Limits] = detectVoice('C:\Users\Vikram\Documents\EDU\Summer 2012\GMM\MALE_microphone\arkadeep.wav'); %Limits in frame no.
Limits = (Limits-1)/fs; %Limits in time
peakdetect(peakdetect<Limits(1,1)) = [];
for i = 1:(size(Limits,1)-1)
    peakdetect(peakdetect>Limits(i,2) & peakdetect<Limits(i+1,1)) = [];
end
peakdetect(peakdetect>Limits(i+1,2)) = [];
plot(round(peakdetect/.01+1), classbymaxp(round(peakdetect/.01+1)), 'o', 'color', 'r');

bl2 = [7.7 7.84 11.23 11.48 11.6 14.3 15.1 15.25 21 21.35 22.7 24.75 25 30.4 31.1 40.6 49.5 51 51.2 52 52.1 52.55 53.2 55.85 56.5 56.7 57.8];
for i = 1:length(bl2)
    line([round(bl2(i)/.01+1) round(bl2(i)/.01+1)], yL, 'LineStyle', '--', 'LineWidth', 2, 'color', 'r');
end


%% Satyamev Jayate vid



