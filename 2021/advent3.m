%% Part 1
data = readlines("input3.txt");
data = double( data.split("") );
x = rmmissing(data,2);
common_bits = sum(x,1) > size(x,1)/2;
gamma = bin2dec(num2str(common_bits));
epsilon = bin2dec(num2str(~common_bits));
gamma * epsilon


%% Part 2
data = readlines("input3.txt");
data = double( data.split("") );
x = rmmissing(data,2);

oxy_bit = x;
co2_bit = x;
for i = 1:size(x,2)
    oxy_common_bit = sum(oxy_bit(:,i)) >= size(oxy_bit,1)/2;
    co2_common_bit = sum(co2_bit(:,i)) < size(co2_bit,1)/2;
    if size(oxy_bit,1) > 1
        oxy_bit = oxy_bit( oxy_bit(:,i) == oxy_common_bit, : );
    end
    if size(co2_bit,1) > 1
        co2_bit = co2_bit( co2_bit(:,i) == co2_common_bit, : );
    end
    if (size(oxy_bit,1) < 1) && (size(co2_bit,1) < 1)
        break;
    end
end

bin2dec(num2str(oxy_bit)) * bin2dec(num2str(co2_bit))