clc; clear; close all;

s = tf('s');

%% Original system
num = [3.462];
den = [5703.2704 75.52 0];
sys = tf(num, den);

%% Plant in simplified form (same system, just factored)
G = 1 / ((1 + 75.52*s) * 75.52*s);

%% Lead compensator (part b)
alpha = 0.438;
T = 25.2;
Glead = (1 + T*s) / (1 + alpha*T*s);

%% New gain
Knew = 23.2;

%% Loop-shaped open-loop
Gol_b = Knew * Glead * G;

%% Plot both on the same figure
figure;
hold on;
margin(sys);        % original
margin(Gol_b);      % loop-shaped
grid on;

legend('without Loop Shaping', 'with Loop Shaping');
title('Comparison: Original vs Loop-shaped Open-loop');
