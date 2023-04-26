%%NEWTON FRACTAL
%% Main settings
%resolution
resX = 600;
resY = 600;

polynomialRoots = [1+1i,1-1i,-1]; 
iterations = 50;

% name
filename = 'fractalVideoExample';


%% ANIMATION
writerObj = VideoWriter(filename,'MPEG-4');
open(writerObj)
%## write root in each frame sequence HERE \/
x = 0:pi/2:(2*pi-pi/4);
%##
for t=0:100
    %## and function HERE \/
    y = (cos(x+2*pi*t/100)+1i*sin(x+2*pi*t/100));
    y = [y 0];
    %##
    frameMatrix = newtonMatrices(y,resX,resY,iterations);
    image(frameMatrix./max(max(frameMatrix)).*254);
    colormap(hsv);
    frame = getframe;
    writeVideo(writerObj,frame);
end
close(writerObj);

%% ONE FRAME
[result distances] = newtonMatrices(polynomialRoots,resX,resY,iterations);
image(result./max(max(result)).*254);
colormap(hsv)

%% LOAD EXAMPLE
% prerendered examples
load("Examples/threeRoots.mat");% write directions to example from current directory
image(matrix./max(max(matrix)).*254);
colormap(hsv)





