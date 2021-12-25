%% Part 1
data = readlines("input20.txt");
algo = char(data(1)) == '#';

img = char(data(3:end)) == '#';

for i = 1:2
    if mod(i,2) == 0
        padval = 1;
    else
        padval = 0;
    end
    img = padarray(img, [2 2], padval, 'both');
    img = nlfilter(img, [3 3], @(sub_img) algoEnhance(sub_img, algo));
    img = img(2:end-1, 2:end-1);
end

sum(img, 'all')


%% Part 2
data = readlines("input20.txt");
algo = char(data(1)) == '#';

img = char(data(3:end)) == '#';

for i = 1:50
    if mod(i,2) == 0
        padval = 1;
    else
        padval = 0;
    end
    img = padarray(img, [2 2], padval, 'both');
    img = nlfilter(img, [3 3], @(sub_img) algoEnhance(sub_img, algo));
    img = img(2:end-1, 2:end-1);
end

sum(img, 'all')

function y = algoEnhance(x, algo)
    binVal = bin2dec(num2str( reshape(x', 1, []) ));
    y = algo(binVal + 1);
end

%% Daniels
% data = readlines("input20.txt");%.replace(["#" "."],["1","0"]);
% 
% algo = char(data(1)) == '#';
% 
% img = char(data(3:end)) == '#';
% padval = 0;
% for i = 1:50
%     img = padarray(img, [2 2], padval, 'both');
%     img = nlfilter(img, [3 3], @(sub_img) algoEnhance(sub_img, algo));
%     img = img(2:end-1, 2:end-1);
%     padval = algo(bin2dec(char(repmat(padval,1,9)+48))+1);
% end
% 
% sum(img, 'all')
% 
% 
% function y = algoEnhance(x, algo)
%     binVal = bin2dec(char(reshape(x', 1, []) + 48));
%     y = algo(binVal + 1);
% end