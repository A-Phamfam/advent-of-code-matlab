%% Part 1
fid = fopen('input2.txt','r');
data = textscan(fid, ['%d' double('-') '%d' '%c' double(':') '%s'], [Inf 4]);
min_occur = data{1};
max_occur = data{2};
char_occur = string(data{3});
password = data{4};

num_occur = cellfun(@(char_occur, password) sum(password == char_occur),...
    char_occur, password)

sum( min_occur <= num_occur & num_occur <= max_occur)


%% Part 2
fid = fopen('input2.txt','r');
data = textscan(fid, ['%d' double('-') '%d' '%c' double(':') '%s'], [Inf 4]);
occur1 = num2cell(data{1});
occur2 = num2cell(data{2});
char_occur = string(data{3});
password = data{4};

num_occur = cellfun(@(char_occur, password) password == char_occur,...
    char_occur, password, UniformOutput=false)

valid = cellfun(@(num_occur, occur1, occur2) xor(num_occur(occur1), num_occur(occur2)),...
    num_occur, occur1, occur2)

sum(valid)