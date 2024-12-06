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

global K_px K_dx K_py K_dy K_pz K_dz K_p_phi K_d_phi K_p_theta K_d_theta K_p_psi K_d_psi Jr I_mat L k b m g;

% TODO: please fill the following control parameters out based on your own 
% design
K_px = 2.0;
K_dx = 1.0;
K_py = 2.0;
K_dy = 1.0;
K_pz = 3.0;
K_dz = 1.5;

K_p_phi = 4.0;
K_d_phi = 2.0;
K_p_theta = 4.0;
K_d_theta = 2.0;
K_p_psi = 3.0;
K_d_psi = 1.5;

% TODO: Please fill the following parameters based on your own UAV
% configuration design
Jr = 0.0001;  % rotational moment of inertia
Ixx = 0.015625;  % moment of inertia at x-axis
Iyy = 0.015625;  % moment of inertia at y-axis
Izz = 0.028125;  % moment of inertia at z-axis
I_mat = diag([Ixx Iyy Izz]);
L = 0.25;  % arm length of quadrotor
k = 0.09;  % lift coefficient
b = 0.07;  % drag coefficient
m = 2.0;  % quadrotor mass
g = 9.81;

% TODO: update the simulink model here to represent your own UAV dynamics
sim('Quadrotor_Model_2.slx');

fprintf("Simulation finished")

%% PLOT RESULT %%
% plot_path_2d(final_path, x_out, y_out, x_bound, y_bound);
plot_path_3d(final_path, x_out, y_out, z_out, bound_orig);