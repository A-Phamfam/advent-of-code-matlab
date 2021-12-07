%% Part 1 - 3D
data = readlines("input17.txt")

readInitState = @(data) ismember(char(data),'#')
initState = cell2mat(arrayfun(readInitState, data,'UniformOutput',false))
cube = padarray(initState, [1 1 2]);

neighborMatrix = ones(3,3,3);
neighborMatrix(2,2,2) = 0;

game_cycles = 6;

for i = 1:game_cycles
    neighbors = convn(cube, neighborMatrix, 'same');
    cube = (cube & (neighbors == 2 | neighbors == 3)) | (~cube & neighbors ==3);

    cubeEdgesMatrix = padarray(zeros(size(cube)-2), [1 1 1], 1);
    numEdgeCells = convn(cube, cubeEdgesMatrix,'valid');
    if numEdgeCells > 0
        cube = padarray(cube, [1 1 1]);
    end
end

sum(cube,'all')


%% Part 2 - 4D
data = readlines("input17.txt")

readInitState = @(data) ismember(char(data),'#')
initState = cell2mat(arrayfun(readInitState, data,'UniformOutput',false))
cube = padarray(initState, [1 1 2 2]);

neighborMatrix = ones(3,3,3,3);
neighborMatrix(2,2,2,2) = 0;

game_cycles = 6;

for i = 1:game_cycles
    neighbors = convn(cube, neighborMatrix, 'same');
    cube = (cube & (neighbors == 2 | neighbors == 3)) | (~cube & neighbors ==3);

    cubeEdgesMatrix = padarray(zeros(size(cube)-2), [1 1 1 1], 1);
    numEdgeCells = convn(cube, cubeEdgesMatrix,'valid');
    if numEdgeCells > 0
        cube = padarray(cube, [1 1 1 1]);
    end
end

sum(cube,'all')


%% 3D Visualization
data = readlines("input17.txt")

readInitState = @(data) ismember(char(data),'#')
initState = cell2mat(arrayfun(readInitState, data,'UniformOutput',false))
cube = padarray(initState, [1 1 2]);

game_cycles = 30;
plim = 20;

figure;
v = VideoWriter('conway.mp4','MPEG-4');
v.FrameRate = 2;
open(v)

for i = 1:game_cycles
    cube = progressCube(cube);

    mid = (size(cube,1)+1)/2;
    [x,y,z] = ind2sub(size(cube), find(cube));
    scatter3(x-mid,y-mid,z-mid,10);
    xlim([-plim plim]); ylim([-plim plim]); zlim([-plim plim]);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title("Day " + i)

    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v)

function nextCube = progressCube(cube)
    neighborMatrix = ones(3,3,3);
    neighborMatrix(2,2,2) = 0;

    neighbors = convn(cube, neighborMatrix, 'same');
    nextCube = (cube & (neighbors == 2 | neighbors == 3)) | (~cube & neighbors ==3);

    cubeEdgesMatrix = padarray(zeros(size(nextCube)-2), [1 1 1], 1);
    numEdgeCells = convn(nextCube, cubeEdgesMatrix,'valid');
    if numEdgeCells > 0
        nextCube = padarray(nextCube, [1 1 1]);
    end
end