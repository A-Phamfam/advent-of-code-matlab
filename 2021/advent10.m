%% Part 1
data = char(readlines("input10.txt"));

delim = containers.Map({')', ']', '}', '>'}, {'(', '[', '{', '<'});
score = containers.Map({')', ']', '}', '>'}, [3, 57, 1197, 25137]);

invalid = {};
allstack = {};
for i = 1:size(data,1)
    stack = {};
    for j = 1:size(data,2)
        if data(i,j) == ' '
            break
        end
        if ismember(data(i,j), {'(', '[', '{', '<'})
            stack = [stack data(i,j)];
        elseif stack{end} == delim(data(i,j))
            stack = stack(1:end-1);
        else
            invalid(i) = {data(i,j)};
            break
        end
    end
    allstack{i} = stack;
end

invalid = invalid( ~cellfun(@isempty, invalid) );
sum(cellfun(@(x) score(x), invalid))


%% Part 2
data = char(readlines("input10.txt"));

delim = containers.Map({')', ']', '}', '>'}, {'(', '[', '{', '<'});
autocompleteScore = containers.Map({'(', '[', '{', '<'}, [1, 2, 3, 4]);

invalid = cell(1,size(data,1));
allstacks = {};
for i = 1:size(data,1)
    stack = {};
    for j = 1:size(data,2)
        if data(i,j) == ' '
            break
        end
        if ismember(data(i,j), {'(', '[', '{', '<'})
            stack = [stack data(i,j)];
        elseif stack{end} == delim(data(i,j))
            stack = stack(1:end-1);
        else
            invalid(i) = {data(i,j)};
            break
        end
    end
    allstacks{i} = stack;
end

validStacks = allstacks( cellfun(@isempty, invalid) );

lineScore = [];
for i = 1:numel(validStacks)
    lineScore(i) = 0;
    for j = numel(validStacks{i}): -1 : 1
        lineScore(i) = 5*lineScore(i);
        lineScore(i) = lineScore(i) + autocompleteScore(validStacks{i}{j});
    end
end

median(lineScore)

