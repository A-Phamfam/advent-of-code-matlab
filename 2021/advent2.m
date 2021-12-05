%% Part 1
data = readtable('input2.txt', TextType="string");
command = data.Var1; amount = data.Var2;
horizontal = sum( amount(command == "forward") );
depth = sum( amount(command == "down") ) - sum( amount(command == "up") );
output = horizontal * depth

%% Part 2

data = readtable('input2.txt', TextType="string");
command = data.Var1; amount = data.Var2;
horizontal = sum( amount(command == "forward") );
aim = cumsum( amount.*(command == "down") - amount.*(command == "up") );
depth = sum( amount(command == "forward") .* aim(command == "forward") );
output = horizontal * depth

%% Plot Demo

data = readtable('input2.txt');
command = string(data.Var1);
amount = data.Var2;
horizontal = cumsum( amount(command == "forward") );
aim = cumsum( amount.*(command == "down") - amount.*(command == "up") );
depth = cumsum( amount(command == "forward") .* aim(command == "forward") );

plot(horizontal, depth)
set(gca, Ydir='reverse')
xlabel('Horizontal')
ylabel('Depth')

%% Demo
data = readtable('input2.txt')
command = string(data.Var1)
amount = data.Var2
command == "forward"

%% Split Apply

data = readtable('input2.txt');
command = categorical(data.Var1); amount = data.Var2;
d = splitapply(@sum, amount, findgroups(command))
output = d(2) * (d(1) - d(3))


%%
data = readtable('input2.txt');
horizontal = sum ( data.Var2( cellfun( @(s) isequal(s, 'forward') , data.Var1) ) );
depth = sum ( data.Var2( cellfun( @(s) isequal(s, 'down') , data.Var1) ) ) - sum ( data.Var2( cellfun( @(s) isequal(s, 'up') , data.Var1) ) );
output = horizontal * depth