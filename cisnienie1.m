clear all; clc; clf; close all;

T  = 0.4;  % okres [s]
Ao = 0.05; % amplituda [m] = 100 000 um  
omega = (2*pi)/T; % predkosc katowa;;
  
k=1;      % licznik pêtli
k2=101;   % licznik pêtli
for t = 0.01 : 0.01 : 0.19;  % [s] próbki czasu
    
  polozenie  =   Ao * cos(omega*t);       % polozenie(t)
  U  =  abs(-Ao * omega * sin(omega*t));  % prdekosc(t)
  Uw(k)=U; 

  [Pn, Pa , x , top_Pn, Q]  = Cisnieie_funkcja2( U , t , k );

  % przypisywanie najwiekszych cisnien;
  wektor_top_Pn(k) = top_Pn;
  wektor_t(k) = t;
  
  % przypisywanie sily nosnej hydrodynamicznej [N/m] z kazdej iteracji
  Fh(k) = Q;
 
  %Wykresy

  figure(k2) 
  plot(x',Pn,'g-');
  legend('Pn');
  k2=k2+1;
  k=k+1;
end

figure(1000) 
plot(wektor_t, wektor_top_Pn,'b-');
legend('Najwieksze wartosci cisnien (t)');
 
figure(1001) 
plot(wektor_t,Fh,'c-');
legend('Pn');
 
