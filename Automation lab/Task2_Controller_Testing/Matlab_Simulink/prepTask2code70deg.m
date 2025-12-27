clc; clear; close all;

s = tf('s');

%% Original system
num = [0.387];
den = [5703.2704 75.52 0];
sys = tf(num, den);

%% Plant in simplified form (same system, just factored)
G = 1 / ((1 + 75.52*s) * 75.52*s);

%% Lead compensator (part b)
alpha = 0.2;
T = 111.8;
Glead = (1 + T*s) / (1 + alpha*T*s);

%% New gain
Knew = 1.23;

%% Loop-shaped open-loop
Gol_b = Knew * Glead * G;

%% Plot both on the same figure
figure;
hold on;
margin(sys);        % original
margin(Gol_b);      % loop-shaped
grid on;

legend('Original plant G_{OL}', 'Loop-shaped G_{OL}');
title('Comparison: Original vs Loop-shaped Open-loop');
