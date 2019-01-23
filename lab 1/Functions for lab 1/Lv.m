function pixels = Lv(inpic, SMOOTH, sigma, shape)
% derivatives operators
sdx = [-1 0 1];% normal difference
sdy = sdx';
cdx = [-0.5 0 0.5];%central difference derivative
cdy = cdx';
sobel_x = [-1 -2 -1; 0 0 0; 1 2 1];
sobel_y = [-1 0 1; -2 0 2; -1 0 1];
roberts_pos_dig = [-1 0; 0 1];
roberts_neg_dig = [0 -1; 1 0];
% dxmask = sdx;
% dymask = sdy;
dxmask = sdx;
dymask = sdy;
% dxmask = sobel_x;
% dymask = sobel_y;
% dxmask = roberts_pos_dig;
% dymask = roberts_neg_dig;

if (nargin < 5)
shape = 'same';
end

% smoothing
if (SMOOTH == true)
    inpic = discgaussfft(inpic, sigma);
end

Lx = conv2(inpic,dxmask ,shape);
Ly = conv2(inpic,dymask, shape);
pixels = Lx.^2 + Ly.^2;
pixels = sqrt(pixels);

end