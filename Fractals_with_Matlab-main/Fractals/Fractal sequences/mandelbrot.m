function [resultMatrix] = mandelbrot(resolutionX,resolutionY,centerX,centerY,rot,sizeX,processDetail)

%automatically calculates sizeY
sizeY = resolutionY/resolutionX*sizeX;
    %swaps the two sides
    change = false;
    if change
        resolutionTemp = resolutionX;
        resolutionX = resolutionY;
        resolutionY = resolutionTemp;
        sizeTemp = sizeX;
        sizeX = sizeY;
        sizeY = sizeTemp;
    end


% DECLARATION OF PARAMETERS
% complex coordinates
real = linspace(centerX - sizeX/2,sizeX/2 + centerX, resolutionX).*(cos(rot)+1i*sin(rot));
imaginary = linspace(centerY + sizeY/2,-sizeY/2 + centerY, resolutionY).*(cos(rot)+1i*sin(rot));
constant = zeros(resolutionY,resolutionX);
for u=1:resolutionY
        for v=1:resolutionX
            constant(u,v) =  real(v) + 1i*imaginary(u);
        end
end
% sequence values
matrix = constant;

% indexes when diverges
resultMatrix = zeros(resolutionY,resolutionX);
tic
for I=processDetail:-1:1 % calculates pixels with distance between each other equal to process detail
    temporarySizeX = floor(resolutionX/I);
    temporarySizeY = floor(resolutionY/I);
    temporaryResult = zeros(temporarySizeY,temporarySizeX); % for the output of the current progress
    for u=1:temporarySizeY % each row that is being calculated
        for v=1:temporarySizeX % each column
            x = I*u;
            y = I*v;
            while resultMatrix(x,y) < 60 && matrix(x,y)*conj(matrix(x,y)) < 1000 % applies function until the value is over 1000
                resultMatrix(x,y) = resultMatrix(x,y)+1;
                matrix(x,y) = matrix(x,y)*matrix(x,y) + constant(x,y);
            end
            temporaryResult(u,v) =  resultMatrix(x,y);
        end
    end
    maxValue = max(max(temporaryResult)); % stretches the values to the whole colormap
    image(temporaryResult./maxValue.*254); % shows the calculated result
    colormap(gray);
    getframe;
end
maxValue = max(max(resultMatrix));
image(resultMatrix./maxValue.*254);
colormap(gray);
toc
return;

% USEFUL COMMANDS FOR EDITING OUTPUT FURTHER
% colormapeditor




