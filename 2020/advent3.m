%% Part 1
fid = fopen('input3.txt','r');
data = textscan(fid,'%s');
s = cellfun(@(x) double(x), data{1}, UniformOutput=false);
s = cat(1, s{:});
istree = s == double('#');

height = size(istree,1);
width = size(istree,2);
vert = 2:height;
horz = mod(4:3:3*height, width);
horz(horz == 0) = width;
stop_location = sub2ind( size(istree), vert, horz );

sum(istree(stop_location))

%% Part 2

fid = fopen('input3.txt','r');
data = textscan(fid,'%s');
s = cellfun(@(x) double(x), data{1}, UniformOutput=false);
s = cat(1, s{:});
istree = s == double('#');

tree_counts = arrayfun(@(dx, dy) count_tree(istree, dx, dy), ...
    [1, 3, 5, 7, 1], [1, 1, 1, 1, 2])

prod(tree_counts)

function num_tree = count_tree(istree, dx, dy)
height = size(istree,1);
width = size(istree,2);
vert = dy+1:dy:height;
horz = mod(dx+1 : dx : dx*(numel(vert)+1), width);
horz(horz == 0) = width;
stop_location = sub2ind( size(istree), vert, horz );

num_tree = sum(istree(stop_location));
end