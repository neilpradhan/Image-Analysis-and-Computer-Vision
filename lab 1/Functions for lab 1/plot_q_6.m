% figure
lvv = Lvvtilde(discgaussfft(house, 4), 'same');
lvvv = Lvvvtilde(discgaussfft(tools, 4), 'same');
subplot(2,3,1)
contour(Lvvtilde(discgaussfft(tools, 4), 'same'), [0 0]);
title(sprintf('zero crossing, scale = %.1f', 4));
axis('image')
axis('ij')
subplot(2,3,2)
showgrey(Lvvvtilde(discgaussfft(tools, 4), 'same') < 0);
title(sprintf('sign variation, scale = %.1f', 4));
axis('image')
axis('ij')
subplot(2,3,3)
m = lvv;
m(lvvv>0) = NaN;          
contour(m, [0 0]);
title(sprintf('lvv = 0 & lvvv < 0, scale = %.1f', 4));
axis('image')
axis('ij')
subplot(2,3,4)
contour(Lvvtilde(discgaussfft(tools, 16), 'same'), [0 0]);
title(sprintf('zero crossing, scale = %.1f', 16));
axis('image')
axis('ij')
subplot(2,3,5)
showgrey(Lvvvtilde(discgaussfft(tools, 16), 'same') < 0);
title(sprintf('sign variation, scale = %.1f', 16));
axis('image')
axis('ij')
subplot(2,3,6)
lvv = Lvvtilde(discgaussfft(tools, 16), 'same');
lvvv = Lvvvtilde(discgaussfft(tools, 16), 'same');
m = lvv;
m(lvvv>0) = NaN;
contour(m, [0 0]);
title(sprintf('lvv = 0 & lvvv < 0, scale = %.1f', 16));
axis('image')
axis('ij')  