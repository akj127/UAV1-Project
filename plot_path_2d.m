function [] = plot_path_2d(path_list, x_out, y_out, x_bound, y_bound)
% Plot the path in green as well as obstacles in red and landmarks in blue dots
% inputs:
% path_list: list of coords of points in the path

figure
size_path = size(path_list);
num_sec = size_path(1);
for i = 1 : num_sec - 1  % plot path in green lines
    curr_pt = path_list(i, :);
    next_pt = path_list(i + 1, :);
    x_list = [curr_pt(1), next_pt(1)];
    y_list = [curr_pt(2), next_pt(2)];
    plot(x_list, y_list, 'g');
    hold on
end

x_out_data = x_out.Data;
y_out_data = y_out.Data;
size_sim = size(x_out_data);
len_sim = size_sim(1);
for i = 1 : len_sim - 1
    curr_x = x_out_data(i, :);
    curr_y = y_out_data(i, :);
    next_x = x_out_data(i + 1, :);
    next_y = y_out_data(i + 1, :);
    x_out_list = [curr_x, next_x];
    y_out_list = [curr_y, next_y];
    plot(x_out_list, y_out_list, 'b');
    hold on
end

xlim(x_bound)
ylim(y_bound)
hold off
end