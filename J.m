clc 
load("chf01m.mat")
x=val(1:2500);
% ECG SIGNAL
figure(1)
subplot(2,1,1)
plot(x, 'linewidth', 2);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Congestive Heart Failure ECG', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
y=abs(fft(x));
% FFT OF ECG SIGNAL
subplot(2,1,2)
plot(y, 'linewidth', 2);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Congestive Heart Failure ECG', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
ylim([0,50000])
xlim([0,200])

fs=2500;
ts=0:1/fs:1-(1/fs);
noise=5*sin(2*pi*0.6*ts);
%NOISE
figure(2)
subplot(2,1,1) 
% plot(ts,noise, 'linewidth', 2)
% set(gca, 'fontsize', 13, 'fontweight', 'bold');
% title('Noise signal', 'fontsize', 15);
% xlabel('Time (s)');
% ylabel('Amplitude (mV)');

% FFT OF NOISE
subplot(2,1,2)
% plot(abs(fft(noise)), 'linewidth', 2)
% xlim([0,200])
% set(gca, 'fontsize', 13, 'fontweight', 'bold');
% title('FFT of Noise', 'fontsize', 15);
% xlabel('Time (s)');
% ylabel('Amplitude (mV)');
%ECG SIGNAL WITH NOISE
figure(3)
n=x+noise;
subplot(2,1,1) 
plot(n, 'linewidth', 2)
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Noisy ECG signal', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
% FFT OF ECG SIGNAL WITH NOISE
q=abs(fft(n));
subplot(2,1,2)
plot(q)
xlim([0,200]);
ylim([0,20000]);
plot(q, 'linewidth', 2)
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Spectrum of Noisy ECG signal', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');

%DESIGN OF HIGH PASS FILTER
b=zeros(1,21);
b(1)=1;
b(11)=-2;
b(21)=1;
a=[1 -2 1];
% DESIGN OF LOW PASS FILTER 
c=[1];
d=zeros(1,241);
d(1)=240;
d(2)=1;
d(121)=1;
d(241)=1;
% FIRST TIME FILTERING
lpy=filter(b,a,n);
l=filter(c,d,lpy);
% SUBTRACTION OF PROCESSED SIGNAL FROM ORIGINAL SIGNAL
k=n-l;
% FILTERING THE DIFFERENCE SIGNAL
j=filter(b,a,k);
h=filter(c,d,j);
% RECONSTRUCTION OF SIGNAL
final=h+l;
% PLOTTING THE FILTERED SIGNAL
figure(2)
subplot(2,1,1) 
final=final.*0.004
plot(final, 'linewidth', 2)
xlim([0,1500]);
ylim([-0.6,0.6]); 
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('ECG Signal Filtered using Improved IIR Integer Filter', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');



subplot(2,1,2) 
plot(abs(fft(final)), 'linewidth', 2);
title('FREQUENCY RESPONSE OF FILTERED ECG SIGNAL', 'fontsize', 15);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
xlabel('Frequency (in Hz)');
ylabel('Magnitude');
xlim([0,200])