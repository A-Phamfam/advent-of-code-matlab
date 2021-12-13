%% Part 1
points = rmmissing(readmatrix("input13.txt"));
flip = rmmissing(readlines("input13.txt").extractAfter("fold along ")).split('=')

x = points(:,1); y = points(:,2);
paper = zeros(max(y) + 1, max(x) + 1);
paper( sub2ind(size(paper), y+1, x+1) ) = 1;

for i = 1
    loc = flip(i,2).double;
    if flip(i,1) == "y"
        paper = paper(1:loc, :) + flipud(paper(loc+2:end, :));
        nnz(paper)
    elseif flip(i,1) == "x"
        paper = fliplr(paper(:, 1:loc)) + paper(:, loc+2:end);
        nnz(paper)
    end
end


%% Part 2
points = rmmissing(readmatrix("input13.txt"));
flip = rmmissing(readlines("input13.txt").extractAfter("fold along ")).split('=')

x = points(:,1); y = points(:,2);
paper = zeros(max(y) + 1, max(x) + 1);
paper( sub2ind(size(paper), y+1, x+1) ) = 1;

for i = 1:size(flip,1)
    loc = flip(i,2).double;
    if flip(i,1) == "y"
        paper = paper(1:loc, :) + flipud(paper(loc+2:end, :));
    elseif flip(i,1) == "x"
        paper = fliplr(paper(:, 1:loc)) + paper(:, loc+2:end);
    end
end

figure;
imagesc(paper > 0)