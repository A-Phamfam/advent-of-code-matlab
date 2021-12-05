%% Part 1

data = readcell("input4.txt",Delimiter='',LineEnding='\n\r')
valid = cellfun(@(data) count(data, ["byr","iyr","eyr","hgt","hcl","ecl","pid"]) >= 7,...
    data)

sum(valid)


%% Part 2

data = readcell("input4.txt",Delimiter='',LineEnding='\n\r')

x = regexp(data{1}, "([a-z]{3})[:]([a-z0-9]+)", 'tokens')
table(x{1}(2), 'VariableNames', x{1}(1))