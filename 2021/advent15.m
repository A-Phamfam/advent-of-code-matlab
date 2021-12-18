%% Part 1
risk = arrayfun(@str2num, char(readlines("input15.txt")));
loc = string((1:size(risk,1))')  + "," +  string(1:size(risk,2));

left = @(x) x(:, 1:end-1);
right = @(x) x(:, 2:end);
up = @(x) x(1:end-1, :);
down = @(x) x(2:end, :);

G = digraph;

G = addedge(G, [left(loc) right(loc)], [right(loc) left(loc)], [right(risk) left(risk)]);
G = addedge(G, [up(loc) down(loc)], [down(loc), up(loc)], [down(risk), up(risk)]);

distances(G, '1,1', string(size(risk,1)) + "," + string(size(risk,2)))


%% Part 2
risk = arrayfun(@str2num, char(readlines("input15.txt")));

mult = num2cell( (0:4)' + (0:4) );

riskExpanded = cell2mat(cellfun(@(x) x + risk, mult, 'UniformOutput', false));
riskExpanded = mod(riskExpanded - 1, 9) + 1;

loc = string((1:size(riskExpanded,1))')  + "," +  string(1:size(riskExpanded,2));

left = @(x) x(:, 1:end-1);
right = @(x) x(:, 2:end);
up = @(x) x(1:end-1, :);
down = @(x) x(2:end, :);

G = digraph;

G = addedge(G, [left(loc) right(loc)], [right(loc) left(loc)], [right(riskExpanded) left(riskExpanded)]);
G = addedge(G, [up(loc) down(loc)], [down(loc), up(loc)], [down(riskExpanded), up(riskExpanded)]);

distances(G, '1,1', string(size(riskExpanded,1)) + "," + string(size(riskExpanded,2)))