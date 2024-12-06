clear all
close all

%% PATH PLANNING %% 
wait_time = 0.1;  % wait time of signal

% frame bound for plotting
x_bound = [-200, 50];  
y_bound = [-10, 120];  

% get path
[final_path, final_yaw] = plan_path();

%% MODEL LAUNCH %%
% get input signal
[x_in, y_in, z_in, yaw_in] = compute_sim_in(final_path, final_yaw, wait_time);

    global K_px K_dx K_py K_dy K_pz K_dz K_p_phi K_d_phi K_p_theta K_d_theta K_p_psi K_d_psi Jr I_mat L k b m g;

% TODO: please fill the following control parameters out based on your own 
% design
K_px = 0.0;
K_dx = 0.0;
K_py = 0.0;
K_dy = 0.0;
K_pz = 0.0;
K_dz = 0.0;

K_p_phi = 0.0;
K_d_phi = 0.0;
K_p_theta = 0.0;
K_d_theta = 0.0;
K_p_psi = 0.0;
K_d_psi = 0.0;

%% moment of inertia calculation
M_drone = 0.5; % Mass of the drone's spherical body (kg)
M_motor = 0.1; % Mass of each motor (kg)
L = 0.25;      % Arm length (m)
r_prop = 0.1;  % Propeller radius (m)
% Calculations
r = L / 4; % Radius of the spherical body
% Moments of inertia
I_xx = (2/5) * M_drone * r^2 + 2 * L^2 * M_motor;
I_yy = I_xx; % I_xx and I_yy are the same
I_zz = (2/5) * M_drone * r^2 + 4 * L^2 * M_motor;
% Rotor moment of inertia
J_r = 0.01 * M_motor * r_prop^2;
%%

% TODO: Please fill the following parameters based on your own UAV
% configuration design
% Jr = 0.0;  % rotational moment of inertia
% Ixx = 0.0;  % moment of inertia at x-axis
% Iyy = 0.0;  % moment of inertia at y-axis
% Izz = 0.0;  % moment of inertia at z-axis
I_mat = diag([Ixx Iyy Izz]);
% L = 0.0;  % arm length of quadrotor
k = 0.005;  % thrust coefficient
b = 0.0001;  % drag coefficient
m = 0.5 + 0.5 + (0.1*4) + (0.2 * 3);  % quadrotor mass(body, sensor, motor, cell)
g = 9.81;

% TODO: update the simulink model here to represent your own UAV dynamics
sim('Quadrotor_Model.slx');

fprintf("Simulation finished")

%% PLOT RESULT %%
plot_path_2d(final_path, x_out, y_out, x_bound, y_bound);
% plot_path_3d(final_path, height, x_out, y_out, z_out, bound_orig);