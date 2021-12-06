%% Part 1
fishes = readmatrix("input6.txt");
fish_count = histcounts(fishes, 0:9)';
days = 80;

% Population Matrix
M = circshift(eye(9), 1, 2);
M(7,1) = 1;

sum(M^days*fish_count)


%% Part 2
fishes = readmatrix("input6.txt");
fish_count = histcounts(fishes, 0:9)';
days = 256;

% Population Matrix
M = circshift(eye(9), 1, 2);
M(7,1) = 1;

sum(M^days*fish_count)


%% Distribution Visualization
v = VideoWriter('fish_growth.mp4','MPEG-4');
v.FrameRate = 30;
open(v)
figure;
for days = 1:256
    fishes = readmatrix("input6.txt");
    fish_count = histcounts(fishes, 0:9)';
    
    % Population Matrix
    M = circshift(eye(9), 1, 2);
    M(7,1) = 1;

    bar(0:8,M^days*fish_count)
    title("Fish Distribution for Day " + days)
    xlabel('Days until giving birth for fish')
    ylabel('Number of Fish')
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v)