function Lvv = Lvvtilde(inpic, shape)
if (nargin < 2)
    shape = 'same';
end


dx = [0 0 0 0 0; 0 0 0 0 0; 0 -0.5 0 0.5 0; 0 0 0 0 0; 0 0 0 0 0];
dy = dx';
dxx = [0 0 0 0 0; 0 0 0 0 0; 0 1 -2 1 0; 0 0 0 0 0; 0 0 0 0 0];
dyy = dxx';
dxy = conv2(dx, dy, shape);

Lx = conv2(inpic,dx,shape);
Ly = conv2(inpic,dy,shape);
Lxx = conv2(inpic,dxx,shape);
Lxy = conv2(inpic,dxy,shape);
Lyy = conv2(inpic,dyy,shape);

Lvv = Lx.* Lx.* Lxx + 2 * Lx.* Ly.* Lxy + Ly.* Ly.* Lyy;

end