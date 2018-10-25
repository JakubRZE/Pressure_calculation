function [ h ] = wysokosc_h2( x , t)

h = 0.5*x.^2 - 0.002*x + 2E-06 + wysokosc_pierscienia( t ); % kszta³t wycinka pierscienia(parabola) i jego wysokosc od (t)

end

