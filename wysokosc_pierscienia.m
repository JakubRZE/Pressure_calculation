function [ wys ] = wysokosc_pierscienia( t )

wys = - 5E-05 * t.^2 + 1E-05 * t - 3E-22; % [m] = 0.5um , parabola (unoszenie pierscienia (t))

end
