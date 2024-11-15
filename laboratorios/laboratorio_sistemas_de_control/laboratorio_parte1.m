% =========================================================================
% LABORATORIO DE CONTROL DE ALTURA DEL DRON CRAZYFLIE
% Sistemas de control 1
% -------------------------------------------------------------------------
% Parte 1: Simulación de controlador PID de altura para el modelo
% simplificado de un dron en condiciones ideales
% =========================================================================

%% Simulación
% Parámetros del sistema
m = 0.023;  % masa del dron en kg
g = 9.81;   % gravedad en m/s^2

% Parámetros del controlador PID
Kp = 6.00;  % Ganancia proporcional
Ki = 2.50;  % Ganancia integral
Kd = 0.50;  % Ganancia derivativa
integral_error = 0;
prev_error = 0;

% Altura objetivo
h_objetivo = 0.5; % Altura deseada en metros

% Tiempo de simulación
t_final = 5;  % Duración en segundos
dt = 0.01;     % Intervalo de tiempo

% Variables de estado inicial
h = 0;  % Altura inicial
v = 0;  % Velocidad inicial

% Vectores para guardar resultados
time = 0:dt:t_final;
h_values = zeros(size(time));
v_values = zeros(size(time));
u_values = zeros(size(time));  % Para graficar la señal de control
error_values = zeros(size(time));  % Para graficar el error

% Bucle de simulación
for i = 1:length(time)
    % Cálculo del error
    error = h_objetivo - h;
    
    % Controlador PID
    integral_error = integral_error + error * dt;
    derivative_error = (error - prev_error) / dt;
    u = Kp * error + Ki * integral_error + Kd * derivative_error;
    prev_error = error;
    
    a = (u - m * g) / m;  % Aceleración
    v = v + a * dt;       % Velocidad
    h = h + v * dt;       % Altura
    
    h_values(i) = h;
    v_values(i) = v;
    u_values(i) = u;
    error_values(i) = error;
end

% Graficar resultados
figure;
%subplot(3, 1, 1);
plot(time, h_values, 'LineWidth', 2);
yline(h_objetivo, '--', 'LineWidth', 1.5, 'Color', [0.5, 0, 0]); % Línea punteada en 0.5
xlabel('Tiempo (s)');
ylabel('Altura (m)');
title('Simulación de la altura del dron (modelo simplificado)');
grid on;

%%
subplot(3, 1, 2);
plot(time, error_values, 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('Error (m)');
title('Error de Altura');
grid on;

subplot(3, 1, 3);
plot(time, u_values, 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('Señal de Control');
title('Señal de Control con Saturación');
grid on;