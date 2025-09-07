function dx = boiler_model(t, x, u)
    % x(1) = water level (m)
    % u = feedwater flow (kg/s)

    % Parameters
    A = 1.0;         % Cross-sectional area of drum (m^2)
    k = 0.05;        % Steam outflow constant
    
    % Dynamics
    level = x(1);
    steam_out = k * sqrt(level);   % steam leaving
    dlevel = (u - steam_out) / A;
    
    dx = dlevel;
end
