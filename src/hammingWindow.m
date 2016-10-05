function hamming()

for N=[8,64,512]
    
% INITIALIZATIONS    

k = floor((N-1)/2);        
hd = zeros(1,3*N); % Initialize Desired Response Vector with zeroes
h = zeros(1,3*N);  % Initialize Windowed Response Vector with zeroes
w = zeros(1,3*N);  % Initialize Window Vector with zeroes
wcut = pi/4;       % Cutoff Frequency of LPF = pi/4

% LOW PASS FILTER DESIGN - DESIRED RESPONSE

for n = 1:3*N
    if n==k
        hd(n) = wcut/pi;
    else
        hd(n) = (sin(wcut*(n-k)))/(pi*(n-k));
    end
end

figure, stem(hd);
xlabel('n');
ylabel('Impulse Response hd(n)');
title(['Desired Response for N=',int2str(N)]);

% HAMMING WINDOW

for n=1:N
    w(n)=0.54-0.46*cos(2*pi*(n)/(N-1));
end

% WINDOWED FILTER RESPONSE

for n=1:N
    h(n)=hd(n)*w(n);
end

w1 = -pi:pi/(256):pi;  

figure, stem(h);
xlabel('n');
ylabel('Impulse Response h(n)');
title(['Windowed Response for N=',int2str(N)]);

figure, freqz(h,1,w1);
xlabel('Frequency w');
ylabel('Magnitude |H(w)|');
title(['Frequency Response of Windowed LPF for N=',int2str(N)]);

% SIGNAL FILTERING USING WINDOWED LPF

n=0:10000;

x = sin(pi/8 *n) + sin(pi/1.25 *n);  % 2 sinusoids are used - Passband (pi/8) and Stopband (4pi/5) frequencies
y = filtfilt(h,1,x);                % Filtering the signal
z = abs(fft(y));                     % Frequency Spectrum
z1 = fftshift(z);

FL = [-length(z)/2+1 : length(z)/2]*2*pi/length(z);

figure
subplot(2,1,1);
plot(FL,10*log(z1));
xlabel('Frequency w');
ylabel('Magnitude |Y(w)|');
title(['Frequency Spectrum (Clean Signal) for N=',int2str(N)]);
    
% NOISE-ADDED SIGNAL FILTERING    
    
noise = rand(size(x));  % Generating random noise
x1= x + noise;             % Adding white noise
y1 = filtfilt(h,1,x1); 
z2 = abs(fft(y1));     
z3 = fftshift(z2);

subplot(2,1,2);
plot(FL,10*log(z3));  
xlabel('Frequency w');
ylabel('Magnitude |Y1(w)|');
title(['Frequency Spectrum (Noisy Signal) for N=',int2str(N)]);

% SNR CALCULATION
    
SNR = 10*log(mean(x.^2)/mean(noise.^2));
   
end

key = waitforbuttonpress;
if(key == 1)
    close all;
end

end
