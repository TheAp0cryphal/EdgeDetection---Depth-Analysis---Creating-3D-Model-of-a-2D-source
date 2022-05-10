clear all ;
% Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');

[M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = rectify_pair(K1n, K2n, R1n, R2n, t1n, t2n);

maxDisp = 20; 
windowSize = 3;

dispM = get_disparity(im1, im2, maxDisp, windowSize);

[JL, JR, bbL, bbR] = warp_stereo(im1, im2, M1, M2) ;

JL = flip(JL, 2);
JR = flip(JR, 2);

depthM = get_depth(dispM, K1n, K2n, R1n, R2n, t1n, t2n);
rectify_disparity = get_disparity(JL, JR, maxDisp, windowSize);
rectify_depth = get_depth (rectify_disparity, K1n, K2n, R1n, R2n, t1n, t2n);

figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;
figure; imagesc(depthM.*(im1>40)); colormap(gray); axis image;
figure; imagesc(rectify_disparity.*(JL>40)); colormap(gray); axis image;
figure; imagesc(rectify_depth.*(JL>40)); colormap(gray); axis image;


