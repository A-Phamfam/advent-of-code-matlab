%% Part 1
rules = readlines("input7.txt")
rule_parse = arrayfun(@(rule) regexp(rule, "([a-z ]+) bags contain ([1-9a-z ,]+)", 'tokens'),...
            rules);

outer_parse = cellfun(@(rule) rule(1), rule_parse);
contain_parse = cellfun(@(rule) regexp(rule(2), "[1-9] (\w[a-z ]+) bag", "tokens"), rule_parse, 'UniformOutput',false);

G = digraph;
for i = 1:numel(outer_parse)
    for j = 1:numel(contain_parse{i})
        G = addedge(G, contain_parse{i}{j}, outer_parse(i));
    end
end

isParent = distances(G,'shiny gold') > 0 & ~isinf(distances(G,'shiny gold'));
sum(isParent)

figure;
plot(G)


%% Part 2
rules = readlines("input7.txt");
rule_parse = arrayfun(@(rule) regexp(rule, "([a-z ]+) bags contain ([1-9a-z ,]+)", 'tokens'),...
            rules);

outer_parse = cellfun(@(rule) rule(1), rule_parse);
contain_parse = cellfun(@(rule) regexp(rule(2), "([1-9]) (\w[a-z ]+) bag", "tokens"), rule_parse, 'UniformOutput',false);

G = digraph;
for i = 1:numel(outer_parse)
    for j = 1:numel(contain_parse{i})
        G = addedge(G, contain_parse{i}{j}(2), outer_parse(i), double(contain_parse{i}{j}(1)));
    end
end
G = flipedge(G);

isChild = distances(G,'shiny gold') >= 0 & ~isinf(distances(G,'shiny gold'));
subG = subgraph(G, isChild);

totalBags = 0;
for i = 1:numel(subG.Nodes)
    [~, edgePaths] = allpaths(subG, "shiny gold", cell2mat(subG.Nodes.Name(i)));
    pathWeight = @(edgePath) prod(subG.Edges.Weight(edgePath));
    numBagType = cellfun(pathWeight, edgePaths);
    totalBags = totalBags + sum(numBagType);
end
totalBags - 1

figure;
LWidths = 5*subG.Edges.Weight/max(subG.Edges.Weight);
plot(subG,'EdgeLabel',subG.Edges.Weight,'LineWidth',LWidths);