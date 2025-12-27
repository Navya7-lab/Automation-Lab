% --- Load Schwarze workspace ---
S = load('schwarze_M_workspace.mat');

t = S.step_data.Time;     % time vector
Y = S.step_data.Data;     % data matrix

T = Y(:,4);               % Temperature (Sensor 1)

%% --- Define step time (known from experiment) ---
step_time = 300;          % step applied at 300 s

%% --- Crop data after step ---
idx = t >= step_time;     % indices after step

t_crop = t(idx);
T_crop = T(idx);

%% --- Shift time so step starts at 0 ---
t_shift = t_crop - step_time;

%% --- Keep only first 800 seconds ---
idx2 = t_shift <= 800;

t_shift = t_shift(idx2);
T_crop = T_crop(idx2);

%% --- Plot step response ---
figure;
plot(t_shift, T_crop, 'r', 'LineWidth', 1.4);
grid on;
xlabel('Time after step (s)');
ylabel('Temperature (°C)');
title('Schwarze Method – Step Response (Shifted)');
xlim([0 800]);

%% --- Compute t10, t50, t90 ---
T0 = T_crop(1);               % initial temperature
Tfinal = T_crop(end);         % final temperature

T10 = T0 + 0.1*(Tfinal - T0);
T50 = T0 + 0.5*(Tfinal - T0);
T90 = T0 + 0.9*(Tfinal - T0);

% Find times
t10 = t_shift(find(T_crop >= T10, 1));
t50 = t_shift(find(T_crop >= T50, 1));
t90 = t_shift(find(T_crop >= T90, 1));

%% --- Print results ---
fprintf('Schwarze Method Results:\n');
fprintf('t10 = %.2f s\n', t10);
fprintf('t50 = %.2f s\n', t50);
fprintf('t90 = %.2f s\n', t90);
