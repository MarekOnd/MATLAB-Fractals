%% MANDELBROT PROGRAM
%% Main Settings
% resolution
resX = 1000;
resY = 1000;
%center
cX = -0.69;
cY = 0; 
% rotation
rot = 0;
%scale of width and height (very very unintuitive)
sX = 2;
% shows calculation process
processDetail = 20;
%% CALCULATE MANDELBROT with current settings
result = mandelbrot(resX,resY,cX,cY,rot,sX,processDetail);

%% CALCULATE NOVA FRACTAL with current settings
result = nova(resX,resY,cX,cY,rot,sX,processDetail);