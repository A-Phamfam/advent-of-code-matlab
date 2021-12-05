%% Part 1
x = readmatrix('input1.txt');
output = sum(diff(x) > 0)

%% Part 2
x = readmatrix('input1.txt');
y = movsum(x,3);
output = sum(diff(y(2:end-1)) > 0)