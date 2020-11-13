clc;
clear;
close all;

Fs = 44100;
f = 440;

t = 0:1/Fs:0.1;

triangle = sawtooth(2*pi*f*t,1/2);
sine = sin(2*pi*f*t);
sawtooth = sawtooth(2*pi*f*t);
square = square(2*pi*f*t);

num = 1;
switch(num)
    case 1
        func = sine;
    case 2
        func = triangle;
    case 3
        func = sawtooth;
    case 4
        func = square;
end

A = linspace(0, 0.02, length(func)*0.20);
D = linspace(0.02, 0.04, length(func)*0.15);
S = linspace(0.04, 0.07, length(func)*0.50);
R = linspace(0.07, 0.10, length(func)*0.20);
ADSR = [A D S R];

x = zeros(size(func));
x(1:length(ADSR)) = ADSR;
tone = func.*x;

% sound(tone, Fs);

%% Plots %%
plot(x, tone);
%% Audio%%
% sound(sine,Fs,16);
% pause(1);
% sound(triangle,Fs,16);
% pause(1);
% sound(sawtooth,Fs,16);
% pause(1);
% sound(square,Fs,16);
% pause(1);

