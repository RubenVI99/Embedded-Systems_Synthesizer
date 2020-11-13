clc;
clear;
close all;

Fs = 44100;

m_coeff = 0.5;

Am = 5;
fm = 440;

Ac = Am/m_coeff;
fc = 20;


t = 0:1/Fs:2;
% Por alguna razón importa el orden en el que se ponen...
lfo_triangle = sawtooth(2*pi*fc*t,1/2);
triangle = sawtooth(2*pi*fm*t,1/2);
lfo_sawtooth = sawtooth(2*pi*fc*t);
sawtooth = sawtooth(2*pi*fm*t);
lfo_square = square(2*pi*fc*t);
square = square(2*pi*fm*t);
lfo_sine = sin(2*pi*fc*t);
sine = sin(2*pi*fm*t);

num = input("Forma de Onda\n    1. Seno\n    2. Triángulo\n    3. Dientes de Sierra\n    4. Cuadrada\n");
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
num = input("Forma de Onda LFO\n    1. Seno\n    2. Triángulo\n    3. Dientes de Sierra\n    4. Cuadrada\n");
switch(num)
    case 1
        lfo = lfo_sine;
    case 2
        lfo = lfo_triangle;
    case 3
        lfo = lfo_sawtooth;
    case 4
        lfo = lfo_square;
end

func = Am*func;
lfo = Ac*lfo; g


modulated_func = Ac*(1 + m_coeff*func).*lfo;
%% Plots %%
subplot 311
plot(t, func, 'k');
subplot 312
plot(t, lfo, 'k');
subplot 313
plot(0:length(modulated_func)-1, modulated_func, 'r');
% plot(t, multiplied_func, 'r');

%% Audio%%
sound(func,Fs,16);
pause(2);
sound(lfo,Fs,16);
pause(2);
sound(modulated_func,Fs,16);
% sound(multiplied_func, Fs, 16);
pause(2);

% sound(triangle,Fs,16);
% pause(1);
% sound(sawtooth,Fs,16);
% pause(1);
% sound(square,Fs,16);
% pause(1);

    