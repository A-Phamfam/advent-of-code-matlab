%% Part 1
octopuses = arrayfun(@str2num, char(readlines("input11.txt")));

steps = 100;

flashes = 0;
for i = 1:steps
    octopuses = octopuses + 1;
    mustFlash = octopuses > 9;
    hasFlashsed = zeros(size(octopuses));
    while any(mustFlash, "all")
        octopuses = octopuses + conv2(mustFlash, ones(3,3), "same");
        hasFlashsed = hasFlashsed | mustFlash;
        mustFlash = (octopuses > 9) & ~hasFlashsed;
    end
    flashes = flashes + sum(octopuses > 9, "all");
    octopuses( octopuses > 9 ) = 0;
end
flashes


%% Part 2
octopuses = arrayfun(@str2num, char(readlines("input11.txt")));

step = 1;
while true
    octopuses = octopuses + 1;
    mustFlash = octopuses > 9;
    hasFlashsed = zeros(size(octopuses));
    while any(mustFlash, "all")
        octopuses = octopuses + conv2(mustFlash, ones(3,3), "same");
        hasFlashsed = hasFlashsed | mustFlash;
        mustFlash = (octopuses > 9) & ~hasFlashsed;
    end
    flashes = flashes + sum(octopuses > 9, "all");
    octopuses( octopuses > 9 ) = 0;
    if all(~octopuses, 'all')
        break
    end
    step = step + 1;
end
step

%% Octopus Visualization
octopuses = arrayfun(@str2num, char(readlines("input11.txt")));

steps = 305;

figure;
gif('octopuses.gif','DelayTime',0.1)
flashes = 0;
for i = 1:steps
    octopuses = octopuses + 1;
    mustFlash = octopuses > 9;
    hasFlashsed = zeros(size(octopuses));
    while any(mustFlash, "all")
        octopuses = octopuses + conv2(mustFlash, ones(3,3), "same");
        hasFlashsed = hasFlashsed | mustFlash;
        mustFlash = (octopuses > 9) & ~hasFlashsed;
        imagesc(octopuses); hold on;
        spy(hasFlashsed,"r*"); hold off;
        title("Step " + i);
        gif
    end
    flashes = flashes + sum(octopuses > 9, "all");
    octopuses( octopuses > 9 ) = 0;
end