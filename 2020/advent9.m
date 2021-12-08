%% Part 1
x = readmatrix("input9.txt")';

nPreamble = 25;

combos = nchoosek(1:nPreamble, 2);
nPerms = size(combos,1);

M = zeros(nPerms, nPreamble);
combo_loc = sub2ind(size(M), repmat((1:nPerms)',1,2), combos);
M( combo_loc ) = 1;

comboSum = conv2(x,M);
comboSum = comboSum(:, nPreamble : end - nPreamble);

isValid = arrayfun(@(i) ...
                any(ismember( comboSum(:,i), x(nPreamble+i))), ...
            1:size(comboSum,2));

x(find(~isValid) + nPreamble)

%% Part 2
x = readmatrix("input9.txt")';

nPreamble = 25;

combos = nchoosek(1:nPreamble, 2);
nPerms = size(combos,1);

M = zeros(nPerms, nPreamble);
combo_loc = sub2ind(size(M), repmat((1:nPerms)',1,2), combos);
M( combo_loc ) = 1;

comboSum = conv2(x,M);
comboSum = comboSum(:, nPreamble : end - nPreamble);

isValid = arrayfun(@(i) ...
                any(ismember( comboSum(:,i), x(nPreamble+i))), ...
            1:size(comboSum,2));

invalidIdx = find(~isValid) + nPreamble;
invalidNum = x(invalidIdx);

rangeFound = false;
for i = 1:invalidIdx
    for j = i:invalidIdx
        if sum(x(i:j)) == invalidNum
            rangeFound = true;
            break;
        end
    end
    if rangeFound
        break;
    end
end
min(x(i:j)) + max(x(i:j))