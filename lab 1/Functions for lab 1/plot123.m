house = godthem256;
tools = few256;
scale = [0.0001 1 4 16 64];

figure('name', 'zero crossings')
for n = 1 : 5
    subplot(2,3,n)
    contour(Lvvtilde(discgaussfft(tools, scale(n)), 'same'), [0 0]);
    axis('image')
    axis('ij')
    if n == 1
        title(sprintf('scale = %.4f', scale(1)));
    else
        title(sprintf('scale = %.1f', scale(n)));
    end        
end

