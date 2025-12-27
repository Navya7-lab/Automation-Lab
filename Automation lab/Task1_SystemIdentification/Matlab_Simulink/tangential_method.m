% Load data
t = step_data.Time;
Y = step_data.Data;

T1 = Y(:,4);        % Temperature (Sensor 1)
H1 = Y(:,2);        % Heater 1 input

%% --- Detect step time automatically ---
[~, k] = max(abs(diff(H1)));
t_step = t(k+1);

%% --- Crop data after step & shift time ---
t_shift = t(t >= t_step) - t_step;
T1_crop = T1(t >= t_step);

%% --- Limit to 800 s ---
mask = t_shift <= 800;
t_shift = t_shift(mask);
T1_crop = T1_crop(mask);

%% --- Plot ---
figure;
plot(t_shift, T1_crop, 'b', 'LineWidth', 1.4);
grid on;
xlabel('Time after step (s)');
ylabel('Temperature (°C)');
title('Step Response (Shifted to Step Time)');
xlim([0 max(t_shift)]);
ylim([min(T1_crop)-1 max(T1_crop)+1]);

fprintf('Detected heater step at t = %.2f s\n', t_step);
