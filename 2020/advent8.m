%% Part 1
commands = readtable("input8.txt");

accum = 0;
step = 1;
line = 1;
while true
    switch cell2mat(commands.Var1(line))
        case 'nop'
            commands.Var3(line) = step;
            step = step + 1;
            line = line + 1;
        case 'acc'
            accum = accum + commands.Var2(line);
            commands.Var3(line) = step;
            step = step + 1;
            line = line + 1;
        case 'jmp'
            commands.Var3(line) = step;
            step = step + 1;
            line = line + commands.Var2(line);
    end
    if commands.Var3(line) ~= 0
        commands
        disp("Infinite Loop")
        break
    end
end
accum


%% Part 2
commands = readtable("input8.txt");

for i = 1:size(commands,1)
    fixed_commands = commands;
    switch cell2mat(fixed_commands.Var1(i))
        case 'nop'
            fixed_commands.Var1(i) = {'jmp'};
        case 'jmp'
            fixed_commands.Var1(i) = {'nop'};
        case 'acc'
            continue;
    end
    [fixed, accum] = run_commands(fixed_commands);
    if fixed
        break;
    end
end

accum

function [fixed, accum] = run_commands(commands)
accum = 0;
step = 1;
line = 1;
while true
    switch cell2mat(commands.Var1(line))
        case 'nop'
            commands.Var3(line) = step;
            step = step + 1;
            line = line + 1;
        case 'acc'
            accum = accum + commands.Var2(line);
            commands.Var3(line) = step;
            step = step + 1;
            line = line + 1;
        case 'jmp'
            commands.Var3(line) = step;
            step = step + 1;
            line = line + commands.Var2(line);
    end
    if line == size(commands,1) + 1
        disp("Program terminated")
        fixed = true;
        return
    end
    if commands.Var3(line) ~= 0
        disp("Infinite Loop")
        fixed = false;
        return
    end
end
end