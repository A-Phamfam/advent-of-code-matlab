%% Part 1
data = readlines("input9.txt").split("");
data = double( data(:,2:end-1) );
sum(data(imregionalmin(data,4))+1)


%% Part 2
data = readlines("input9.txt").split("");
data = double( data(:,2:end-1) );

basins = bwconncomp(data < 9, 4);
basinSize = cellfun(@numel,basins.PixelIdxList);
basinSize = sort(basinSize);
prod(basinSize(end-2:end))

%% Plots
figure;
pcolor(data);
shading flat
colormap(jet)

figure;
pcolor(~(data < 9));
shading flat;
colormap(jet)


figure;
pcolor(~imregionalmin(data,4))
shading flat;
colormap(jet)


%% Part 1 Manual
data = readlines("input9.txt").split("");
Z = double( data(:,2:end-1) )

Zabove = circshift(Z,1,1);  Zabove(1,:) = 9;
Zbelow = circshift(Z,-1,1); Zbelow(end,:) = 9;
Zleft = circshift(Z,1,2);   Zleft(:,1) = 9;
Zright = circshift(Z,-1,2); Zright(:,end) = 9;

localMin = (Z < Zabove) & (Z < Zbelow) & (Z < Zright) & (Z < Zleft);

sum( Z(localMin)+1 )