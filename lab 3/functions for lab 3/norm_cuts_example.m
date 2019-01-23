colour_bandwidth = 20.0; % color bandwidth
radius = 10;              % maximum neighbourhood distance
ncuts_thresh = 0.4;      % cutting threshold
min_area = 52;          % minimum area of segment
max_depth = 9;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

I = imread('orange.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'result/normcuts1.png')
imwrite(I,'result/normcuts2.png')
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imshow(Inew)
%title('ncuts thresh = 0.4,max depth = 9,min area = 25')
