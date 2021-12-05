x = readmatrix("input1.txt");

%% Part 1
y = x + x';
ind = find(y==2020);
[i,j] = ind2sub(size(y),ind(1));
x(i) * x(j)

%% Part 2

y = x + x' + shiftdim(x,-2);
ind = find(y==2020);
[i,j,k] = ind2sub(size(y),ind(1));
x(i) * x(j) * x(k)
