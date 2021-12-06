%% Part 1
data = readcell("input4.txt",Delimiter='',LineEnding='\n\r')
valid = cellfun(@(data) count(data, ["byr","iyr","eyr","hgt","hcl","ecl","pid"]) >= 7,...
    data)

sum(valid)


%% Part 2
data = readcell("input4.txt",Delimiter='',LineEnding={'\n\r','\n\n'});

dataStruct = struct.empty();
for i = 1:numel(data)
    tokens = regexp(data{i}, "([a-z]{3})[:]([#a-z0-9]+)", 'tokens');
    for j = 1:numel(tokens)
        dataStruct(i).(tokens{j}{1}) = tokens{j}{2};
    end
end

optionsChange = array2table(zeros(0,8), "VariableNames", ["ecl","pid","eyr","byr","iyr","cid","hgt","hcl"]);
dataTable = struct2table(dataStruct);
dataTable = [optionsChange;dataTable];
writetable(dataTable,'temp-advent4.csv');
opt = detectImportOptions("temp-advent4.csv");
opt.VariableTypes([1 2 7 8]) = {'string'};
dataTable = readtable('temp-advent4.csv',opt);
delete('temp-advent4.csv');

validRows = rowfun(@isValid, dataTable, 'OutputFormat','uniform');
sum(validRows)

function output = isValid(ecl, pid, eyr, byr, iyr, cid, hgt, hcl)
try
    hgt_tkns = regexp(hgt, "(\d+)(cm|in)",'tokens');
    hgt_unit = hgt_tkns{1}(2);
    hgt_val = double(hgt_tkns{1}(1));
    if isequal(hgt_unit, "in")
        validHeight = 59 <= hgt_val && hgt_val <= 76;
    elseif isequal(hgt_unit,"cm")
        validHeight = 150 <= hgt_val && hgt_val <= 193;
    else
        output = false;
        return;
    end
    hcl = hcl.extractAfter("#");
    validHcl = (hex2dec("000000") <= hex2dec(hcl) && hex2dec(hcl) <= hex2dec("FFFFFF"));
    validEcl = ismember(ecl, ["amb","blu","brn","gry","grn","hzl","oth"]);
    validIyr = (2010 <= iyr && iyr <= 2020);
    validEyr = (2020 <= eyr && eyr <= 2030);
    validPid = (str2double(pid) && strlength(pid) == 9);
    validByr = (1920 <= byr && byr <= 2002);

    output = validHeight && validByr && validHcl && validEcl && validIyr && validEyr && validPid;
catch
    output = false;
end
end