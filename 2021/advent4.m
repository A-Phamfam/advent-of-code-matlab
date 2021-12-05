clear all
close all

%% Part 1
bingo_numbers = readlines("input4.txt");
bingo_numbers = str2num(bingo_numbers(1));
hands = readmatrix("input4.txt");
hands = mat2cell(hands, 5*ones( 1, size(hands,1)/5 ) );

hand_won = false;
for i = 1:numel(bingo_numbers)
    for j = 1:numel(hands)
        winning_elements = ismember(hands{j}, bingo_numbers(1:i));
        wins_for_row = sum(winning_elements,1);
        wins_for_col = sum(winning_elements,2);
        if any(wins_for_row==5)
            hand_won = true;
            break;
        elseif any(wins_for_col==5)
            hand_won = true;
            break;
        end
    end
    if hand_won
        break;
    end
end

sum(hands{j}(~winning_elements)) * bingo_numbers(i)


%% Part 2
bingo_numbers = readlines("input4.txt");
bingo_numbers = str2num(bingo_numbers(1));
hands = readmatrix("input4.txt");
hands = mat2cell(hands, 5*ones( 1, size(hands,1)/5 ) );

hand_won_order = [];
for i = 1:numel(bingo_numbers)
    for j = 1:numel(hands)
        winning_elements = ismember(hands{j}, bingo_numbers(1:i));
        wins_for_row = sum(winning_elements,1);
        wins_for_col = sum(winning_elements,2);
        if any(wins_for_row==5) && ~ismember(j, hand_won_order)
            hand_won_order = [hand_won_order j];
            last_hand_winning_elems = winning_elements
        elseif any(wins_for_col==5) && ~ismember(j, hand_won_order)
            hand_won_order = [hand_won_order j];
            last_hand_winning_elems = winning_elements
        end
    end
    if numel(hand_won_order) == numel(hands)
        break;
    end
end

sum( hands{hand_won_order(end)}(~last_hand_winning_elems) )...
    * bingo_numbers(i)


%% Part 1 w/o Cells
bingo_numbers = readlines("input4.txt");
bingo_numbers = str2num(bingo_numbers(1));
hands = readmatrix("input4.txt");
hands = reshape(hands, 5, [], 5);
hands = permute(hands, [1 3 2]);

hands_won = false(1, 1, size(hands,3));
for i = 1:numel(bingo_numbers)
    winning_elements = ismember(hands, bingo_numbers(1:i));
    wins_for_rows = sum(winning_elements, 2);
    wins_for_cols = sum(winning_elements, 1);
    hands_won = hands_won | any(wins_for_rows==5,1) | any(wins_for_cols==5, 2);
    if any(hands_won)
        break
    end
end

sum( hands(logical(~winning_elements .* hands_won)) )...
    * bingo_numbers(i)


%% Part 2 w/o Cells
bingo_numbers = readlines("input4.txt");
bingo_numbers = str2num(bingo_numbers(1));
hands = readmatrix("input4.txt");
hands = reshape(hands, 5, [], 5);
hands = permute(hands, [1 3 2]);

hands_won = false(1, 1, size(hands,3));
for i = 1:numel(bingo_numbers)
    winning_elements = ismember(hands, bingo_numbers(1:i))
    wins_for_rows = sum(winning_elements, 2);
    wins_for_cols = sum(winning_elements, 1);
    prev_hands_won = hands_won;
    hands_won = hands_won | any(wins_for_rows==5,1) | any(wins_for_cols==5, 2);
    last_winner = hands_won - prev_hands_won;
    if all(hands_won)
        break
    end
end

sum( hands(logical(~winning_elements .* last_winner)) )...
    * bingo_numbers(i)