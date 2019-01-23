function Lvvv = Lvvvtilde(inpic, shape)
if (nargin < 2)
    shape = 'same';
end

% define simple difference operator
dx = [0 0 0 0 0; 0 0 0 0 0; 0 -0.5 0 0.5 0; 0 0 0 0 0; 0 0 0 0 0];
dy = dx';
dxx = [0 0 0 0 0; 0 0 0 0 0; 0 1 -2 1 0; 0 0 0 0 0; 0 0 0 0 0];
dyy = dxx';
% dxy = conv2(dx, dy, shape);
dxxx = conv2(dx, dxx, shape);
dxxy = conv2(dxx, dy, shape);
dxyy = conv2(dx, dyy, shape);
dyyy = conv2(dy, dyy, shape);

Lx = conv2( inpic,dx,shape);
Ly = conv2(inpic,dy,shape);
Lxxx = conv2(inpic,dxxx,shape);
Lxxy = conv2(inpic,dxxy,shape);
Lxyy = conv2(inpic,dxyy,shape);
Lyyy = conv2(inpic,dyyy,shape);

Lvvv = (Lx .^3) .* Lxxx + 3 * (Lx .^2) .* Ly .* Lxxy + 3 * Lx .* (Ly .^2)...
    .* Lxyy + (Ly .^3) .* Lyyy;

end