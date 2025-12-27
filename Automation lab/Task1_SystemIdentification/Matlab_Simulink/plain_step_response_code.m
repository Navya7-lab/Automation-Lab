t = step_data.Time;        % time vector
Y = step_data.Data;        % data matrix

T1 = Y(:,4);        % Temperature 1 (Sensor 1)
Heater1 = Y(:,2);   % Heater 1 Input (% Power)

figure;
plot(t, T1, 'b-', 'LineWidth', 1.4); hold on;
plot(t, Heater1, 'r-', 'LineWidth', 1.4);  % second parameter
grid on;

xlabel('Time (s)');
ylabel('Value');
title('Step Input and Step Response of TCL');

legend('Step REsponse o fTCL', 'Step Input to TCL');
