%% Part 1
x = readmatrix("input7.txt");
sum(abs(x - median(x)))

%% Part 2
x = readmatrix("input7.txt");
tri_num = @(x) x.*(x+1)/2;
f = @(x_center) sum(tri_num(abs(x-x_center)));
f(round(fminsearch(f, mean(x))))