function [ Pn , Pa , x, top_Pn, Q] = Cisnieie_funkcja2( U , t , k)

tw = 0.01 : 0.01 : 0.2; 
L = 0.004; % [m] = 4000 um = 0,4 cm . Szerokosc szczeliny
ni = 0.09; % lepkosc [N*s/m^2]

h1 = 0.0000015 + wysokosc_pierscienia( t ); % wysokosc wlotu szczeliny [m] = 1,5um
h2 = 0.0000003 + wysokosc_pierscienia( t ); % wysokosc konca szczeliny [m] = 1,5um
h0 = h2;

m = h1/h0-1; % parametr geometryczny
N = 50; % Iloœæ przedzia³ow
dx = L/N; % przyrost
M = N-1; % ilosc wezlow z nieznanymi wartosciami cisnienia

x = [ 0 : dx : L ];
szczelina=wysokosc_h2(x,t);

Pa = (6*ni*U*L)/(m*h0^2)*((2*m+2)./(-2*(2+m)*(1+m*x/L).^2)+1./(1+m*x/L)-1/(2+m));
for i = 1:M
    A(i,i) = ((wysokosc_h2(i*dx+dx/2 , t)^3 + wysokosc_h2(i*dx-dx/2 ,t)^3)/dx^2);
    if i > 1
        A(i,i-1) = -(wysokosc_h2(i*dx-dx/2 , t)^3)/dx^2;
    end
    if i < (M)
        A(i,i+1) = -(wysokosc_h2(i*dx+dx/2 , t)^3)/dx^2;
    end
end

for i = 1:M
    B1=-6*ni*U*((wysokosc_h2(i*dx-dx/2 , t) - wysokosc_h2(i*dx+dx/2 , t))/dx);
    %B2=-12*ni*((wysokosc_h2(i*dx-dx/2 , tw(k+1)) - wysokosc_h2(i*dx+dx/2 , t))/0.01);
    B2=-12*ni*((wysokosc_h2(i*dx , tw(k+1)) - wysokosc_h2(i*dx , t))/0.01);
    %B2= - 12 * ni * ( (wysokosc_pierscienia( tw(k+1) ) - wysokosc_pierscienia( tw(k) ))/0.01);
    % B(i) = -6*ni*U*((wysokosc_h2(i*dx-dx/2 , t) - wysokosc_h2(i*dx+dx/2 , t))/dx) - 12 * ni * ( (wysokosc_pierscienia( tw(k+1) ) - wysokosc_pierscienia( tw(k) ))/0.01);
 
    B1_t(i)=B1;
    B2_t(i)=B2;
    B(i) =B1+B2;
end

Bt = B';
Pn0 = inv(A)*Bt;
Pn = [ 0 ; Pn0 ; 0];

%Pnt = Pn';
%blad = Pa - Pnt; % blad bezwzgledny
%P = (blad/Pa)*100; % blad wzgledny

figure(k)
plot(x,szczelina);

% wybieranie najwiekszej wartosci cisnienia
Pn_T = Pn';
 
top_Pn = Pn_T(1);

for licz = 2:51
     if Pn_T(licz) > top_Pn
         top_Pn = Pn_T(licz);
     end   
end

% Jednostkowa sila nosna hydrodynamiczna [N/m]: (Metoda trapezów)
i=1;
for licz = 1:51
     if Pn_T(licz) >= 0 
         plus_Pn(licz) = Pn_T(licz);
         calka_plus_Pn(i) = Pn_T(licz);
         i=i+1;
     end     
end

Q = trapz(calka_plus_Pn);

figure(k+500)
plot(x',plus_Pn,'r');

%{
figure(k+200)
plot(B1_t,'b');
figure(k+300)
plot(B2_t,'r');
%}
end

