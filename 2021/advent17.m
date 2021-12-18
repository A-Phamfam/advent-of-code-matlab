%% Part 1
bounds = readmatrix("input17.txt", Delimiter=["=", ", " ".."])
bounds(isnan(bounds)) = [];
xbounds = bounds(1:2);
ybounds = bounds(3:4);

yinitial = abs(ybounds(1)) - 1;

yinitial * (yinitial+1) / 2


%% Part 2
bounds = readmatrix("input17.txt", Delimiter=["=", ", " ".."]);
bounds(isnan(bounds)) = [];
xbounds = bounds(1:2);
ybounds = bounds(3:4);


possibleY = (ybounds(1) : abs(ybounds(1))-1)';
possibleX = (0 : xbounds(2));

allowable = zeros(numel(possibleY), numel(possibleX));
totalInitialVelocities = 0;
for t = 1 : 2*abs(ybounds(1))
    xposition = ((possibleX + 0.5)*t - 0.5*t^2) .* ( t-1 < possibleX)...
              + (possibleX .* (possibleX + 1)/2).* ( t-1 >= possibleX);

    yposition = (possibleY + 0.5)* t - 0.5*t^2;

    allowable = allowable | ((ybounds(1) <= yposition & yposition <= ybounds(2)) & ...
        (xbounds(1) <= xposition & xposition <= xbounds(2)));
end

nnz(allowable)