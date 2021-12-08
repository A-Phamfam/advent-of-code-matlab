%% Part 1
data = readcell("input8.txt",Delimiter=' ');

output_sig = data(:, end-3:end);
sum(ismember(cellfun(@length, output_sig), [2, 3, 4, 7]), 'all')

%% Part 2
data = readcell("input8.txt",Delimiter=' ');
data = cellfun(@sort, data,UniformOutput=false);

total = 0;
for i = 1:size(data,1)
    input_sig = data(i, 1:end-5);
    output_sig = data(i, end-3:end);
    sig_length = cellfun(@length, input_sig);

    cipher = cell.empty();
    cipher{1} = input_sig{sig_length == 2};
    cipher{4} = input_sig{sig_length == 4};
    cipher{7} = input_sig{sig_length == 3};
    cipher{8} = input_sig{sig_length == 7};
    
    nintersect1 = cellfun(@(sig) length(intersect(sig, cipher{1})), input_sig);
    nintersect4 = cellfun(@(sig) length(intersect(sig, cipher{4})), input_sig);
    
    cipher{9} = input_sig{sig_length == 6 & nintersect4 == 4};
    cipher{2} = input_sig{sig_length == 5 & nintersect4 == 2};
    cipher{6} = input_sig{sig_length == 6 & nintersect4 == 3 & nintersect1 == 1};
    cipher{3} = input_sig{sig_length == 5 & nintersect4 == 3 & nintersect1 == 2};
    cipher{5} = input_sig{sig_length == 5 & nintersect4 == 3 & nintersect1 == 1};
    cipher{10}= input_sig{sig_length == 6 & nintersect4 == 3 & nintersect1 == 2};
    
    decipher = cellfun(@(sig) mod( find(ismember(cipher, {sig})), 10), output_sig);
    total = total + str2double(join(string(decipher),''));
end
total