function [final_path, final_yaw] = plan_path()
% Execute the path planning algorithm for each part of the task
% outputs:
% final_path: final path for the whole task
% final_yaw: final yaw path for the whole task

% init
init_z = 0;
hover_z = -30.48;
hover_y = 100;
yaw = 0;  % up north

init_n_steps = 1000;
init_x_list = linspace(0, 0, init_n_steps)';
init_y_list = linspace(0, hover_y, init_n_steps)';
init_z_list = linspace(init_z, hover_z, init_n_steps)';
init_path = [init_x_list, init_y_list, init_z_list];
init_yaw_path = linspace(0, 0, init_n_steps)';

% hover
hover_n_steps = 100;
hover_x_list = linspace(0, 0, hover_n_steps)';
hover_y_list = linspace(hover_y, hover_y, hover_n_steps)';
hover_z_list = linspace(hover_z, hover_z, hover_n_steps)';
hover_path = [hover_x_list, hover_y_list, hover_z_list];
hover_yaw_path = linspace(0, 0, hover_n_steps)';

% track 1
track_1_start_x = -5;
track_z = -40;
track_1_speed = 0.5;
track_1_n_steps = 300;
track_1_end_x = track_1_start_x - track_1_speed * track_1_n_steps;
track_1_x_list = linspace(track_1_start_x, track_1_end_x, track_1_n_steps)';
track_1_y_list = linspace(hover_y, hover_y, track_1_n_steps)';
track_1_z_list = linspace(track_z, track_z, track_1_n_steps)';
track_1_path = [track_1_x_list, track_1_y_list, track_1_z_list];
track_1_yaw_path = linspace(1.571, 1.571, track_1_n_steps)';

% track 2
track_2_start_x = track_1_end_x - 5;
track_2_n_steps = 1000;
track_2_radius = 10;
track_2_space = linspace(0, 2 * pi, track_2_n_steps);
track_2_x_list = (track_2_radius * cos(track_2_space) + track_2_start_x - track_2_radius)';
track_2_y_list = (track_2_radius * sin(track_2_space) + hover_y)';
track_2_z_list = ones(track_2_n_steps, 1) * track_z;
track_2_path = [track_2_x_list, track_2_y_list, track_2_z_list];
track_2_yaw_path = linspace(0, 6.283, track_2_n_steps)';

% return
return_n_steps = 1000;
return_x_list = linspace(track_2_start_x, track_2_start_x, return_n_steps)';
return_y_list = linspace(hover_y, hover_y, return_n_steps)';
return_z_list = linspace(track_z, 0, return_n_steps)';
return_path = [return_x_list, return_y_list, return_z_list];
return_yaw_path = linspace(6.283, 6.283, return_n_steps)';

% total_path
final_path = [init_path; hover_path; track_1_path; track_2_path; return_path];
final_yaw = [init_yaw_path; hover_yaw_path; track_1_yaw_path; track_2_yaw_path; return_yaw_path];
end