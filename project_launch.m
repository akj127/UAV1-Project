clear all
close all

%% PATH PLANNING %% 
wait_time = 0.1;  % wait time of signal

% frame bound for plotting
x_bound = [-200, 50];  
y_bound = [-10, 120];
% define bound orig for 3d plotting
bound_orig = [-200, 50];

% get path
[final_path, final_yaw] = plan_path();

%% MODEL LAUNCH %%
% get input signal
[x_in, y_in, z_in, yaw_in] = compute_sim_in(final_path, final_yaw, wait_time);

% TODO: please fill the following control parameters out based on your own 
% design

%% moment of inertia calculation
num_cells = 2;
M_drone = 1 + 0.2*num_cells; % Mass of the drone's spherical body (kg)
M_motor = 0.1; % Mass of each motor (kg)
% L = 0.25;      % Arm length (m)
% r_prop = 0.1;  % Propeller radius (m)
% % Calculations
% r = L / 4; % Radius of the spherical body
% % Moments of inertia
% Ixx = (2/5) * M_drone * r^2 + 2 * L^2 * M_motor;
% Iyy = Ixx; % I_xx and I_yy are the same
% Izz = (2/5) * M_drone * r^2 + 4 * L^2 * M_motor;
% % Rotor moment of inertia
% Jr = 0.01 * M_motor * r_prop^2;
% 
% I_mat = diag([Ixx Iyy Izz]);
% % L = 0.0;  % arm length of quadrotor
% k = 0.005;  % thrust coefficient
% b = 0.0001;  % drag coefficient
% m =M_drone + 4* M_motor;  % quadrotor mass(body, sensor, motor, cell)
% g = 9.81;
%% parameters
K_px = 0.00003;
K_dx = 0.00001;
K_py = 0.0;
K_dy = 0.0;
K_pz = 0.0001;
K_dz = 0.001;
K_p_phi = 0.05;
K_d_phi = 0.01;
K_p_theta = 0.0002;
K_d_theta = 0.1;
K_p_psi = 0.4;
K_d_psi = 0.136;
%%
Jr = 1.6129e-05;  % rotational moment of inertia
Ixx = 0.03411283500000001;  % moment of inertia at x-axis
Iyy = Ixx;  % moment of inertia at y-axis
Izz = 0.06314503500000002;  % moment of inertia at z-axis
I_mat = diag([Ixx Iyy Izz]);
L = 0.381;  % arm length of quadrotor
k = 0.09;  % lift coefficient
b = 0.07;  % drag coefficient
m = 1.8;  % quadrotor mass
g = 9.81;

% TODO: update the simulink model here to represent your own UAV dynamics
sim('Quadrotor_Model.slx');

fprintf("Simulation finished")

%% PLOT RESULT %%
plot_path_2d(final_path, x_out, y_out, x_bound, y_bound);

%plot_path_3d(final_path, x_out, y_out, z_out, bound_orig);