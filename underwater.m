clc
clear all
close all
if (exist ('OCTAVE_VERSION', 'builtin'))% for Octave
    pkg load image
    pkg load signal
end
inpath = 'D:\RefPic\';%path for reading image
outpath = 'I:\';% path for saving results
doDegradation = 1; % 0/1  - if 0, the image itself is restored.
%%% if 1, image is degraded at first, then the degraded image is restored back again by
%%% available methods to its original. use this only if you have perfect underwater image
%%% and you want to see the mean squared error.
warning('off', 'all')% suppress all warnings
num = 5;%suffix for reading frame
inpath=sprintf('%swater (%d).png',inpath,num);% image filename
% % % fast methods
% method = [17.00 16.00 15.00 14.00 13.00 12.01 12.00 11.00 10.00 9.00 8.01 8.00 7.00 6.01 6.00 5.00 4.00 3.00 2.01 2.00 1.01 1.02 1.03 1.07 1.08 1.09];
method = 1.10;
pwd0=pwd;%current dir

cd(pwd0);
for i = 1:1%length(method)
    tic
    evaluations(inpath,outpath,doDegradation,method(i));
    toc
    cd(pwd0);
    fprintf('\n\n');
    % close all
end

doDegradation = 0;
for i = 1:1%length(method)
    tic
    evaluations(inpath,outpath,doDegradation,method(i));    
    toc
    cd(pwd0);
    fprintf('\n\n');
    % close all
end
%%%return
