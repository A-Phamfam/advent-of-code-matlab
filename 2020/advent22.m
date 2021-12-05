
data = readmatrix('test.txt');
data = reshape(rmmissing(data),[],2);
p1 = data(:,1);
p2 = data(:,2);

while true
    n = min(numel(p1), numel(p2));
    p1wins = p1(1:n) > p2(1:n);
    p1won_cards = [p1(p1wins), p2(p1wins)]';
    p2won_cards = [p2(~p1wins), p1(~p1wins)]';
    p1 = [p1(n+1:end); p1won_cards(:)]
    p2 = [p2(n+1:end); p2won_cards(:)]
    if isempty(p1)
        winner = p2;
        break;
    elseif isempty(p2)
        winner = p1;
        break;
    else
        continue;
    end
end

output = sum(fliplr(winner') .* (1:numel(winner)))