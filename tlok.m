clear all; clc; clf; close all;

T  = 0.4;  % okres [s]
Ao = 0.05; % amplituda [m] = 100 000 um
omega = (2*pi)/T; % predkosc katowa;;
  
 k=1;
 for t = 0 : 0.01 : 0.2;  % [s] próbki czasu
    
  X  =   Ao * cos(omega*t);       % polozenie(t)
  U  =  abs(-Ao * omega * sin(omega*t));  % prdekosc(t)
  
  wX(k) = X;
  wU(k) = U; 
   
  k=k+1;
 end
  
  t = 0 : 0.01 : 0.2; 
  plot(t,wX,'g-', t,wU,'b'); 