function [resultMatrix] = newton(roots,resolutionX,resolutionY,processDetail)
%-- code adapted from Mandelbrot
p = poly(roots);
dp = polyDerivative(p);

% real and imaginary max root difference
realDif = max(real(roots))- min(real(roots));
imagDif = max(imag(roots))- min(imag(roots));

% calculates the center of the image
centerX = min(real(roots))+realDif/2;
centerY = min(imag(roots))+imagDif/2;

%automatically calculates sizes to contain the area around roots
sizeX = resolutionX/resolutionY*realDif;
sizeY = resolutionY/resolutionX*imagDif;


% DECLARATION OF PARAMETERS
% complex coordinates
re = linspace(centerX - sizeX/2,sizeX/2 + centerX, resolutionX);
im = linspace(centerY + sizeY/2,-sizeY/2 + centerY, resolutionY);
constant = zeros(resolutionY,resolutionX);
for u=1:resolutionY
        for v=1:resolutionX
            constant(u,v) =  re(v) + 1i*im(u);
        end
end
% sequence values
matrix = constant;

% indexes when diverges
resultMatrix = zeros(resolutionY,resolutionX);
tic
for I=processDetail:-1:1
    temporarySizeX = floor(resolutionX/I);
    temporarySizeY = floor(resolutionY/I);
    temporaryResult = zeros(temporarySizeY,temporarySizeX);
    for u=1:temporarySizeY
        for v=1:temporarySizeX
            x = I*u;
            y = I*v;
            for K=1:50 %do 50 iterations

                % calculate next newton method
                matrix(x,y) = matrix(x,y) - polyval(p,matrix(x,y))/polyval(dp,matrix(x,y));
                % check if close to root
                for R=1:size(roots,2)
                   vec = matrix(x,y)-roots(1,R); 
                   dist = vec*conj(vec);
                   if(dist < 0.01)
                        resultMatrix(x,y) = R;
                        temporaryResult(u,v) = R;
                        break;
                   end
                end
                if resultMatrix(x,y) ~= 0
                    break;
                end
            end
        end
    end
    maxValue = max(max(temporaryResult));
    image(temporaryResult./maxValue.*254);
    colormap(gray);
    getframe;
end
maxValue = max(max(resultMatrix));
image(resultMatrix./maxValue.*254);
colormap(gray);
getframe;
toc
return;
% USEFUL COMMANDS
% colormapeditor



