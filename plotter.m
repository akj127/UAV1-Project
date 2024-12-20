close all;

% Time intervals (in seconds)
takeoff_end = 100;       % End of takeoff and travel
hover_end = 110;         % End of hover
animal_a_end = 140;      % End of Animal A tracking
animal_b_end = 240;      % End of Animal B tracking
landing_end = 350;       % End of landing

% Figure size configuration for LaTeX compatibility
figure_width = 6; % Width in inches (matches \textwidth in LaTeX)
figure_height = 6; % Height in inches (adjust height as needed for subplots)
figure_resolution = 300; % Resolution in DPI for high-quality images

% Extract data if the variables are timeseries objects
if isa(x_out, 'timeseries')
    x_data = x_out.Data;
    y_data = y_out.Data;
    z_data = z_out.Data;
    x_dot_data = x_dot_out.Data;
    y_dot_data = y_dot_out.Data;
    z_dot_data = z_dot_out.Data;
    theta_data = theta_out.Data; % Keep in radians
    phi_data = phi_out.Data;     % Keep in radians
    psi_data = psi_out.Data;     % Keep in radians
    q_c_data = q_c_out.Data;
    p_c_data = p_c_out.Data;
    z_c_data = z_c_out.Data;
    r_c_data = r_c_out.Data;
    theta_dot_data = theta_dot_out.Data;
    phi_dot_data = phi_dot_out.Data;
    psi_dot_data = psi_dot_out.Data;
    time = x_out.Time; % Assuming all timeseries have the same time vector
else
    % Assuming numeric arrays
    x_data = x_out;
    y_data = y_out;
    z_data = z_out;
    x_dot_data = x_dot_out;
    y_dot_data = y_dot_out;
    z_dot_data = z_dot_out;
    theta_data = theta_out; % Keep in radians
    phi_data = phi_out;     % Keep in radians
    psi_data = psi_out;     % Keep in radians
    q_c_data = q_c_out;
    p_c_data = p_c_out;
    z_c_data = z_c_out;
    r_c_data = r_c_out;
    theta_dot_data = theta_dot_out;
    phi_dot_data = phi_dot_out;
    psi_dot_data = psi_dot_out;
    time = (1:length(x_out)) / 10; % Fallback time vector, assuming 100 Hz sample rate
end

% Plot for the entire mission
fig = figure('Units', 'inches', 'Position', [0, 0, figure_width, figure_height]); % Set figure size
subplot(5, 1, 1);
plot(time, x_data, 'r', time, y_data, 'g', time, z_data, 'b');
legend('x', 'y', 'z');
xlabel('Time (s)'); ylabel('Position'); title('Position vs Time');

subplot(5, 1, 2);
plot(time, x_dot_data, 'r', time, y_dot_data, 'g', time, z_dot_data, 'b');
legend('x\_dot', 'y\_dot', 'z\_dot');
xlabel('Time (s)'); ylabel('Velocity'); title('Velocity vs Time');

subplot(5, 1, 3);
plot(time, theta_data, 'r', time, phi_data, 'g', time, psi_data, 'b');
legend('\theta', '\phi', '\psi');
xlabel('Time (s)'); ylabel('Attitude (rad)'); title('Attitude vs Time');

subplot(5, 1, 4);
plot(time, theta_dot_data, 'r', time, phi_dot_data, 'g', time, psi_dot_data, 'b');
legend('\theta\_dot', '\phi\_dot', '\psi\_dot');
xlabel('Time (s)'); ylabel('Attitude Rates'); title('Attitude Rates vs Time');

subplot(5, 1, 5);
plot(time, q_c_data, 'r', time, p_c_data, 'g', time, z_c_data, 'b', time, r_c_data, 'k');
legend('q_c', 'p_c', 'z_c', 'r_c');
xlabel('Time (s)'); ylabel('Control Inputs'); title('Control Inputs vs Time');

% Save the entire mission plot
set(fig, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, figure_width, figure_height]);
print(fig, 'entire_mission', '-dpng', ['-r', num2str(figure_resolution)]);

% Subset plots
for i = 1:length(subsets)
    subset = subsets{i};
    t_indices = find(time >= subset(1) & time <= subset(2));
    t_range = time(t_indices);

    fig = figure('Units', 'inches', 'Position', [0, 0, figure_width, figure_height]); % Set figure size
    subplot(5, 1, 1);
    plot(t_range, x_data(t_indices), 'r', t_range, y_data(t_indices), 'g', t_range, z_data(t_indices), 'b');
    legend('x', 'y', 'z', 'Location', 'bestoutside');
    xlabel('Time (s)'); ylabel('Position'); title(['Position - ', subset_titles{i}]);

    subplot(5, 1, 2);
    plot(t_range, x_dot_data(t_indices), 'r', t_range, y_dot_data(t_indices), 'g', t_range, z_dot_data(t_indices), 'b');
    legend('x\_dot', 'y\_dot', 'z\_dot', 'Location', 'bestoutside');
    xlabel('Time (s)'); ylabel('Velocity'); title(['Velocity - ', subset_titles{i}]);

    subplot(5, 1, 3);
    plot(t_range, theta_data(t_indices), 'r', t_range, phi_data(t_indices), 'g', t_range, psi_data(t_indices), 'b');
    legend('\theta', '\phi', '\psi', 'Location', 'bestoutside');
    xlabel('Time (s)'); ylabel('Attitude (rad)'); title(['Attitude - ', subset_titles{i}]);

    subplot(5, 1, 4);
    plot(t_range, theta_dot_data(t_indices), 'r', t_range, phi_dot_data(t_indices), 'g', t_range, psi_dot_data(t_indices), 'b');
    legend('\theta\_dot', '\phi\_dot', '\psi\_dot', 'Location', 'bestoutside');
    xlabel('Time (s)'); ylabel('Attitude Rates'); title(['Attitude Rates - ', subset_titles{i}]);

    subplot(5, 1, 5);
    plot(t_range, q_c_data(t_indices), 'r', t_range, p_c_data(t_indices), 'g', t_range, z_c_data(t_indices), 'b', t_range, r_c_data(t_indices), 'k');
    legend('q_c', 'p_c', 'z_c', 'r_c', 'Location', 'bestoutside');
    xlabel('Time (s)'); ylabel('Control Inputs'); title(['Control Inputs - ', subset_titles{i}]);

    % Save the subset plot
    set(fig, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, figure_width, figure_height]);
    print(fig, strrep(subset_titles{i}, ' ', '_'), '-dpng', ['-r', num2str(figure_resolution)]);
end
