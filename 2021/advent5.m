%% Part 1
lines = readmatrix("input5.txt",'Delimiter',{',', ' -> '});
lines( (lines(:,1)~=lines(:,3)) & (lines(:,2)~=lines(:,4)), : ) = [];
lines = permute(lines, [2 3 1]);
x1 = lines(1,:,:); x2 = lines(3,:,:); y1 = lines(2,:,:); y2 = lines(4,:,:);

[x, y] = meshgrid( 0:max(lines,[],'all'), 0:max(lines,[],'all') );

inrange = @(P, p1, p2) min(p1,p2) <= P & P <= max(p1,p2);

z = (y == (y2-y1)./(x2-x1).*(x-x1) + y1 ) & inrange(x, x1, x2) & inrange(y, y1, y2);
z = z | ((x1 == x2) & (x == x1) & inrange(y, y1, y2));

z = sum(z,3);

nnz(z >= 2)


%% Part 2
lines = readmatrix("input5.txt",'Delimiter',{',', ' -> '});
lines = permute(lines, [2 3 1]);
x1 = lines(1,:,:); x2 = lines(3,:,:); y1 = lines(2,:,:); y2 = lines(4,:,:);

[x, y] = meshgrid( 0:max(lines,[],'all'), 0:max(lines,[],'all') );

inrange = @(P, p1, p2) min(p1,p2) <= P & P <= max(p1,p2);

z = (y == (y2-y1)./(x2-x1).*(x-x1) + y1 ) & inrange(x, x1, x2) & inrange(y, y1, y2);
z = z | ((x1 == x2) & (x == x1) & inrange(y, y1, y2));

z = sum(z,3);

nnz(z >= 2)


%% Heatmap
figure; pcolor(z);
shading flat; colormap(turbo);