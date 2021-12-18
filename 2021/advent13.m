%% Part 1
points = rmmissing(readmatrix("input13.txt"));
flip = rmmissing(readlines("input13.txt").extractAfter("fold along ")).split('=')

x = points(:,1); y = points(:,2);
paper = zeros(max(y) + 1, max(x) + 1);
paper( sub2ind(size(paper), y+1, x+1) ) = 1;

for i = 1
    loc = flip(i,2).double;
    if flip(i,1) == "y"
        paper = paper(1:loc, :) | flipud(paper(loc+2:end, :));
        nnz(paper)
    elseif flip(i,1) == "x"
        paper = fliplr(paper(:, 1:loc)) | paper(:, loc+2:end);
        nnz(paper)
    end
end

figure;
imagesc(paper)


%% Part 2
points = rmmissing(readmatrix("input13.txt"));
flip = rmmissing(readlines("input13.txt").extractAfter("fold along ")).split('=')

x = points(:,1); y = points(:,2);
paper = zeros(max(y) + 1, max(x) + 1);
paper( sub2ind(size(paper), y+1, x+1) ) = 1;

for i = 1:size(flip,1)
    loc = flip(i,2).double;
    if flip(i,1) == "y"
        paper = paper(1:loc, :) | flipud(paper(loc+2:end, :));
    elseif flip(i,1) == "x"
        paper = fliplr(paper(:, 1:loc)) | paper(:, loc+2:end);
    end
end

figure;
imagesc(fliplr(paper))


%% Folding Visualization
rotationSteps = 12;

points = rmmissing(readmatrix("input13.txt"));
flip = rmmissing(readlines("input13.txt").extractAfter("fold along ")).split('=')

x = points(:,1); y = points(:,2); z = zeros(size(y));

% Create a 3x1xN Matrix - each page is the vector for a point
points = [shiftdim(x,-2); shiftdim(y,-2); shiftdim(z,-2)];

% Rotation matrices
Xaxisrotation = @(phi) [1          0           0;...
                        0  cosd(phi)   -sind(phi);...
                        0  sind(phi)   cosd(phi)];

Yaxisrotation = @(theta) [cosd(theta)     0     sind(theta);...
                                    0     1     0;...
                         -sind(theta)     0     cosd(theta)];


figure(Position=[200 200 1500 600]);
gif('paperfolding.gif','DelayTime',0.1)

[ax1, ax2] = plotPoints(points,'b');
hold(ax1, 'off');
hold(ax2, 'off');
gif

for i = 1:size(flip,1)
    foldLine = flip(i,2).double;
    ang = 180 / rotationSteps;

    if flip(i,1) == "y"
        pointsToRotate = points(:,:, points(2,:,:) >  foldLine) - [0; foldLine; 0];
        pointsNotRotated = points(:,:, points(2,:,:) <=  foldLine);
        for j = 1:rotationSteps
            pointsToRotate = pagemtimes(Xaxisrotation(ang), pointsToRotate);
            plotPoints(pointsNotRotated, 'b');
            [ax1, ax2] = plotPoints(pointsToRotate + [0; foldLine; 0], 'r');

            xlim(ax1, [0 max(points(1,:,:))]);
            ylim(ax1, [0 max(points(2,:,:))]);

            xlim(ax2, [0 max(points(1,:,:))]);
            ylim(ax2, [0 max(points(2,:,:))]);
            zlim(ax2, [-0.6*max(points(2,:,:)) 0.7*max(points(2,:,:))]);
            gif
            hold(ax1, 'off');
            hold(ax2, 'off');
        end
        points = cat(3,pointsNotRotated, pointsToRotate  + [0; foldLine; 0]);

    elseif flip(i,1) == "x"
        pointsToRotate = points(:,:, points(1,:,:) >  foldLine)  - [foldLine; 0; 0];
        pointsNotRotated = points(:,:, points(1,:,:) <=  foldLine);
        for j = 1:rotationSteps
            pointsToRotate = pagemtimes(Yaxisrotation(-ang), pointsToRotate);
            plotPoints(pointsNotRotated, 'b');
            [ax1, ax2] = plotPoints(pointsToRotate + [foldLine; 0; 0], 'r');

            xlim(ax1, [0 max(points(1,:,:))]);
            ylim(ax1, [0 max(points(2,:,:))]);

            xlim(ax2, [0 max(points(1,:,:))]);
            ylim(ax2, [0 max(points(2,:,:))]);
            zlim(ax2, [-0.6*max(points(1,:,:)) 0.7*max(points(1,:,:))]);
            
            gif
            hold(ax1, 'off');
            hold(ax2, 'off');
        end
        points = cat(3,pointsNotRotated, pointsToRotate  + [foldLine; 0; 0]);
    end
    [ax1, ax2] = plotPoints(points,'b')
    for k = 2:-0.1:1
        if flip(i,1) == "y"
            xlim(ax1, [0 max(points(1,:,:))]);
            ylim(ax1, [0 k*max(points(2,:,:))]);

            xlim(ax2, [0 max(points(1,:,:))]);
            ylim(ax2, [0 k*max(points(2,:,:))]);
            zlim(ax2, [-0.6*k*max(points(2,:,:)) 0.7*k*max(points(2,:,:))]);
        else
            xlim(ax1, [0 k*max(points(1,:,:))]);
            ylim(ax1, [0 max(points(2,:,:))]);

            xlim(ax2, [0 k*max(points(1,:,:))]);
            ylim(ax2, [0 max(points(2,:,:))]);
            zlim(ax2, [-0.6*k*max(points(1,:,:)) 0.7*k*max(points(1,:,:))]);
        end
        gif
    end
    hold(ax1, 'off');
    hold(ax2, 'off');
end

% Scale axes final time
for k = 1:0.5:10
    ylim(ax1, [0 k*max(points(2,:,:))]);
    ylim(ax2, [0 k*max(points(2,:,:))]);
    gif
end

function [ax1, ax2] = plotPoints(points, color)
ax1 = subplot(1,2,1);
scatter3(squeeze(points(1,:,:)), squeeze(points(2,:,:)), squeeze(points(3,:,:)), 100, 'filled', color);
hold on;
view(0,-90)
xlabel('x')
ylabel('y')

ax2 = subplot(1,2,2);
scatter3(squeeze(points(1,:,:)), squeeze(points(2,:,:)), squeeze(points(3,:,:)), 100, 'filled', color);
hold on;
view(225,20)
set(gca, "XDir", 'reverse')
xlabel('x')
ylabel('y')
end