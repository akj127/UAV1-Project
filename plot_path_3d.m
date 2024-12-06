function [] = plot_path_3d(path_list, x_out, y_out, z_out, bound_orig)
% Plot the path in green as well as obstacles in red and landmarks in blue dots
% inputs:
% path_list: list of coords of points in the path

size_path = size(path_list);
num_sec = size_path(1);
for i = 1 : num_sec - 1  % plot path in green lines
    curr_pt = path_list(i, :);
    next_pt = path_list(i + 1, :);
    x_list = [curr_pt(1), next_pt(1)];
    y_list = [curr_pt(2), next_pt(2)];
    z_list = [curr_pt(3), next_pt(3)];
    plot3(x_list, y_list, z_list, 'g');
    hold on
end

x_out_data = x_out.Data;
y_out_data = y_out.Data;
z_out_data = z_out.Data;
size_sim = size(x_out_data);
len_sim = size_sim(1);
for i = 1 : len_sim - 1
    curr_x = x_out_data(i, :);
    curr_y = y_out_data(i, :);
    curr_z = z_out_data(i, :);
    next_x = x_out_data(i + 1, :);
    next_y = y_out_data(i + 1, :);
    next_z = z_out_data(i + 1, :);
    x_out_list = [curr_x, next_x];
    y_out_list = [curr_y, next_y];
    z_out_list = [curr_z, next_z];
    plot3(x_out_list, y_out_list, z_out_list, 'b');
    hold on
end

xlim(bound_orig)
ylim(bound_orig)
hold off
end