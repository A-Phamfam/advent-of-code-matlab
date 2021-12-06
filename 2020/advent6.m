%% Part 1
groups = readcell("input6.txt",LineEnding={'\n\r','\n\n'});

groups = cellfun(@(group) group(isletter(group)), groups, 'UniformOutput',false);

sum(cellfun(@(group) numel(unique(group)), groups))


%% Part 2
groups = readcell("input6.txt",Delimiter='\n',LineEnding={'\n\r','\n\n'});

groups = cellfun(@(group) group(isletter(group)), groups, 'UniformOutput',false);
groups = cell2table(groups);

common_answers = rowfun(@charIntersect, groups, ExtractCellContents=true,OutputFormat="cell");

sum(cellfun(@(group) numel(group), common_answers))

function A = charIntersect(varargin)
A = 'abcdefghijklmnopqrstuvwxyz';
for i = 1:numel(varargin)
    if ~ismissing(varargin{i})
        A = intersect(A,varargin{i});
    end
end
end