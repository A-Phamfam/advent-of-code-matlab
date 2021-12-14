%% Part 1
data = readlines("input14.txt");
steps = 10;

% Start Template pairs
template = data(1);
pair = @(x) string([x(1:end-1)' x(2:end)']);
templatePairs = pair(char(template));

% Get the output pairs created from an input pair
rules = data(3:end).split(" -> ");
inPair = rules(:,1);
outPair1 = join([rules(:,1).extract(1), rules(:,2)], "");
outPair2 = join([rules(:,2) rules(:,1).extract(2)], "");

polymerMatrix = (outPair1' == inPair) + (outPair2' == inPair);
templateVector = sum(templatePairs' == inPair, 2);

nPairs = polymerMatrix^steps * templateVector;

letters = string(unique(char(inPair)));

lastLetter = template.extract(template.strlength);
nLetters = sum( nPairs.*(inPair.extract(1) == letters'), 1) + (lastLetter == letters')

max(nLetters) - min(nLetters)


%% Part 2
data = readlines("input14.txt");
steps = 40;

% Start Template pairs
template = data(1);
pair = @(x) string([x(1:end-1)' x(2:end)']);
templatePairs = pair(char(template));

% Get the output pairs created from an input pair
rules = data(3:end).split(" -> ");
inPair = rules(:,1);
outPair1 = join([rules(:,1).extract(1), rules(:,2)], "");
outPair2 = join([rules(:,2) rules(:,1).extract(2)], "");

polymerMatrix = (outPair1' == inPair) + (outPair2' == inPair);
templateVector = sum(templatePairs' == inPair, 2);

nPairs = polymerMatrix^steps * templateVector;

letters = string(unique(char(inPair)));

lastLetter = template.extract(template.strlength);
nLetters = sum( nPairs.*(inPair.extract(1) == letters'), 1) + (lastLetter == letters')

max(nLetters) - min(nLetters)


%% Visualize Matrices

Tpolymer = array2table(polymerMatrix, "VariableNames", inPair, "RowNames", inPair)

Ttemplate = array2table(double(templateVector)', "VariableNames", inPair)

Tout = array2table(nPairs', "VariableNames", inPair)


%% Part 1 - Naive String Creation
data = readlines("input14.txt");
steps = 10;

template = char(data(1));

rules = data(3:end).split(" -> ");
inPair = rules(:,1).char;
outRule = string([inPair(:,1) rules(:,2).char]);
inPair = string(inPair);

pair = @(x) string([x(1:end-1)' x(2:end)']);

for i = 1:steps
    tail = char(template); tail = string(tail(end));
    templatePairs = pair(char(template));
    template = join([replace(templatePairs, inPair, outRule)' tail], "");
end

counts = histcounts(double(template.char))
counts( counts == 0 ) = [];

max(counts) - min( counts )
