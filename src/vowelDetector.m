function distVowel = vowelDetector(speech,fs)

%'C:\Users\Vikram\Documents\EDU\Summer 2012\Vids\sj.wav'

% fig = figure('Name', 'Speech');
% plot(speech, 'linewidth', 1.5);
% set(fig, 'Units', 'normalized', 'Position', [0,0,1,1]);

% Normalising speech
speech = speech(:);
nspeech = speech - mean(speech);
nspeech = (nspeech)/max(abs(nspeech));
% fig = figure('Name', 'NSpeech'); subplot(211); plot(0:1/fs:(n-1)/fs, nspeech, 'linewidth', 1.5); title('Normalised Speech'); xlabel('Time'); ylabel('Amplitude');

% Determining the Power Spectrum of speech using the Yule-Walker Method
% Uses 1024 point FFT
order = round(fs/1000)+2;
[Pxx, freq] = pyulear(nspeech, order, 1024, fs);
% semilogy(freq, abs(Pxx)); title('Power Spectrum'); xlabel('Freq'); ylabel('3dB power');

% Finding Formants
[~, peaks] = findpeaks(abs(Pxx));
allfmnts = freq(peaks);

if length(allfmnts)<3
    th = ar(nspeech,10); %auto-regressive model of vocal tract
    [~,a] = th2tf(th); %conversion into transfer function
    r1 = roots(a);
    r2 = r1(find(angle(r1)<0));
    angles = angle(r2);
    retfmnts = fs/2*(angles/pi);
    fmnts = retfmnts(1:3);
else 
    fmnts = allfmnts(1:3);
end

w = [2 1 1];
A = [730 1090 2440];
E = [530 1840 2480];
I = [390 1990 2550];
O = [570 840 2410];
U = [440 1020 2240];

distA = norm(w.*(A-fmnts'));
distE = norm(w.*(E-fmnts'));
distI = norm(w.*(I-fmnts'));
distO = norm(w.*(O-fmnts'));
distU = norm(w.*(U-fmnts'));

distVowel = [distA distE distI distO distU];

end








