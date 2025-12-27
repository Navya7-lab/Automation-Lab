%% Bode Plot – Plant, PM = 30°, PM = 70°
clear; close all; clc;

%% Plant
num = 0.6;
den = [5703.2704 75.52 0];
G = tf(num, den);

%% Phase margin targets
PM_targets = [30 70];

%% Frequency range
w = logspace(-4,1,3000);

%% Plant frequency response
[magG, phaseG] = bode(G,w);
magG   = squeeze(magG);
phaseG = squeeze(phaseG);

%% Plot setup
figure
subplot(2,1,1)
semilogx(w,20*log10(magG),'k','LineWidth',1.5)
grid on
ylabel('Magnitude (dB)')
title('Bode Plot')

subplot(2,1,2)
semilogx(w,phaseG,'k','LineWidth',1.5)
grid on
ylabel('Phase (deg)')
xlabel('Frequency (rad/s)')
hold on

%% ---- Plant Phase Margin ----
[~,idxG] = min(abs(magG - 1));
wc_G = w(idxG);
PM_G = 180 + phaseG(idxG);

fprintf('Plant: wc = %.4g rad/s, PM = %.2f°\n', wc_G, PM_G);

%% ---- Controller design for target PMs ----
for i = 1:length(PM_targets)

    PM = PM_targets(i);
    desired_phase = PM - 180;

    % Find frequency where phase condition is met
    [~,idx] = min(abs(phaseG - desired_phase));
    wc = w(idx);

    % Gain to make magnitude = 1
    K = 1 / magG(idx);

    % New open-loop system
    L = K * G;

    % Bode of compensated system
    [magL, phaseL] = bode(L,w);
    magL   = squeeze(magL);
    phaseL = squeeze(phaseL);

    % Plot magnitude
    subplot(2,1,1)
    semilogx(w,20*log10(magL),'LineWidth',1.2)
    hold on

    % Plot phase
    subplot(2,1,2)
    semilogx(w,phaseL,'LineWidth',1.2)

    fprintf('PM = %d°:  K = %.4g, wc = %.4g rad/s\n', PM, K, wc);
end

%% Legend
subplot(2,1,1)
legend('Plant','PM = 30°','PM = 70°','Location','best')
