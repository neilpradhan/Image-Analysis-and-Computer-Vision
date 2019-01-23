%define image of your choice and then use this function
smoothing_gauss = img;
smoothing_lowpass = img;
N = 5;

for i = 1 : N
    if i > 1 
        smoothing_gauss = gaussfft(img, 0.45); 
        smoothing_lowpass = ideal(img, 0.32);
        img = rawsubsample(img);
        smoothing_gauss = rawsubsample(smoothing_gauss);
        smoothing_lowpass = rawsubsample(smoothing_lowpass);
        
    end
    subplot(3, N, i)
    showgrey(img);
    subplot(3, N, i+N)
    showgrey(smoothing_gauss);
    subplot(3, N, i+2*N)
    showgrey(smoothing_lowpass);
end