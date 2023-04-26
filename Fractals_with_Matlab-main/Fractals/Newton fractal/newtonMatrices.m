function [resultMatrix, distanceMatrix] = newtonMatrices(roots,resolutionX,resolutionY,iterations)
%-- declarations from previous functions, but all made with matrixes
p = poly(roots);
dp = polyDerivative(p);

% real and imaginary max root difference
realDif = max(real(roots))- min(real(roots));
imagDif = max(imag(roots))- min(imag(roots));

% AUTOMATIC MODE
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

% indexes of to which it converges
resultMatrix = zeros(resolutionY,resolutionX);
% distance from root
distanceMatrix = zeros(resolutionY,resolutionX);

for K=1:iterations % do iterations
    matrix = matrix - polyval(p,matrix)./polyval(dp,matrix);
end
for y=1:resolutionY
        for x=1:resolutionX
                % check if close to root
                resultMatrix(x,y) = 1;
                distanceMatrix(x,y) = (matrix(x,y)-roots(1,1))*conj(matrix(x,y)-roots(1,1));
                for R=2:size(roots,2)
                   vec = matrix(x,y)-roots(1,R); 
                   dist = vec*conj(vec);
                   if  dist < distanceMatrix(x,y) 
                        resultMatrix(x,y) = R;
                        distanceMatrix(x,y) = dist;
                   end
                end
            
        end
end
return;




