lvv = Lvvtilde(discgaussfft(tools, 4), 'same');
m = lvv;
m(lvvv>0) = NaN;          
contour(m, [0 0]);