Fhat = zeros(128, 128);
Fhat(5,9) = 1;
showgrey(Fhat)
F = ifft2(Fhat);
Fabsmax = max(abs(F(:)));
subplot(2,2,1)
showgrey(real(F), 64, -Fabsmax, Fabsmax)
subplot(2,2,2)
showgrey(imag(F), 64, -Fabsmax, Fabsmax)
subplot(2,2,3)
showgrey(abs(F), 64, -Fabsmax, Fabsmax)
subplot(2,2,4)
showgrey(angle(F), 64, -pi, pi)