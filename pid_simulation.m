clc; clear; close all;

% Simulation parameters
T = 200;        % simulation time
dt = 0.1;       % step size
time = 0:dt:T;

% PID gains
Kp = 10;
Ki = 1;
Kd = 2;

% Setpoint (desired level)
setpoint = 5;

% Initialize
x = 2;                  % initial water level
integral = 0;
prev_error = 0;
levels = [];
controls = [];

for t = time
    % Error
    error = setpoint - x;
    integral = integral + error*dt;
    derivative = (error - prev_error)/dt;
    
    % PID control signal
    u = Kp*error + Ki*integral + Kd*derivative;
    if u < 0, u = 0; end
    
    % System dynamics (Euler integration)
    dx = boiler_model(t, x, u);
    x = x + dx*dt;
    
    % Log
    levels(end+1) = x;
    controls(end+1) = u;
    
    prev_error = error;
end

% Plot
figure;
subplot(2,1,1);
plot(time, levels, 'b', 'LineWidth', 1.5); hold on;
yline(setpoint, 'r--', 'Setpoint');
xlabel('Time (s)'); ylabel('Water Level (m)');
title('Boiler Drum Level Control using PID');

subplot(2,1,2);
plot(time, controls, 'k', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Feedwater Flow (kg/s)');
title('Control Input');
