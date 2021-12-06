%% Part 1
passes = readlines("input5.txt");

pass_id = @(pass) bin2dec(num2str(ismember(char(pass),['B','R'])));

max(arrayfun(pass_id, passes))

%% Part 2
passes = readlines("input5.txt");

pass_id = @(pass) bin2dec(num2str(ismember(char(pass),['B','R'])));

seatid = arrayfun(pass_id, passes);

seatid = sort(seatid);
seatid(diff(sorted_seatid) == 2) + 1