%% Part 1
tunnels = readlines("input12.txt").split("-");

G = graph;
for i = 1:size(tunnels,1)
    G = addedge(G, tunnels(i,1), tunnels(i,2));
end

allpaths(G,'start','end')

visited = false(numel(G.Nodes), 1);
path = {};
validPaths = {};
[~, ~, validPaths] = exploreCavesPart1(G,'start','end',visited, path, validPaths);

numel(validPaths)

%% Part 2

tunnels = readlines("input12.txt").split("-");

G = graph;
for i = 1:size(tunnels,1)
    G = addedge(G, tunnels(i,1), tunnels(i,2));
end

visited = zeros(numel(G.Nodes), 1);
path = {};
validPaths = {};
[~, ~, validPaths] = exploreCavesPart2(G,'start','end',visited, path, validPaths);

numel(validPaths)

%% Functions
function [visited, path, validPaths] = exploreCavesPart1(G, head, tail, visited, path, validPaths)
    visited(findnode(G,head)) = true;
    path(end+1) = {head};

    if strcmp(head, tail)
        validPaths{end+1} = path;
    else
        for i = 1:numel(neighbors(G, head))
            nodeNeighbors = neighbors(G,head);
            if ~visited( findnode(G, nodeNeighbors{i}) ) || all(isstrprop(nodeNeighbors{i}, 'upper'))
                [visited, path, validPaths] = exploreCavesPart1(G, nodeNeighbors{i}, tail, visited, path, validPaths);
            end
        end
    end
    path = path(1:end-1);
    visited(findnode(G,head)) = false;
end

function [visited, path, validPaths] = exploreCavesPart2(G, head, tail, visited, path, validPaths)
    visited(findnode(G,head)) = 1 + visited(findnode(G,head));
    path(end+1) = {head};

    if strcmp(head, tail)
        numel(validPaths)
        validPaths{end+1} = path;
    else
        for i = 1:numel(neighbors(G, head))
            nodeNeighbors = neighbors(G,head);
            if ismember(nodeNeighbors{i}, 'start')
                continue
            end
            isLargeCave = cellfun(@(node) all(isstrprop(node,'upper')) ,G.Nodes.Name);
            nodeIdx = @(nIdx) findnode(G, nodeNeighbors{nIdx});
            if isLargeCave( nodeIdx(i) ) || ...
                    visited( nodeIdx(i) ) == 0 || ...
                    visited( nodeIdx(i) ) == 1 && ~any(visited == 2 & ~isLargeCave)
               [visited, path, validPaths] = exploreCavesPart2(G, nodeNeighbors{i}, tail, visited, path, validPaths);
            end
        end
    end
    path = path(1:end-1);
    visited(findnode(G,head)) = -1 + visited(findnode(G,head));
end