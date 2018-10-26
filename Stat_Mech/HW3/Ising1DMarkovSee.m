% October 2017 -- Markov chain algorithm
% Ising1DMarkovSee.m
clear all; close all;

N =  int32(25);
nbr = [N, 2];
for i = 2:N-1
    nbr = [nbr;i-1, i+1];
end
nbr = [nbr; N-1,1];
%
nsteps = 3*10^5;
M = 10;
Averagemags=[];

for T = 1:0.5:4
beta = 1.0 / T;
replacement = true;
S = randsample([-1, +1], N, replacement);
Ss = [S];
mags = zeros(nsteps,1);
for i = 1:nsteps
    k = randi(N,1,1);
    delta_E = 2.0 * S(k) * sum(S(nbr(k,:)));
    if rand < exp(-beta * delta_E)
        S(k) = -S(k);
    end
    magnetization = sum(S);             %%%
    mags(i) =  magnetization; 
    if mod(i, nsteps/M) == 0 
    Ss = [Ss;S];
    
    end
    
 
end
AvgMagnetization = sum(mags)/nsteps  ;   %%%
 Averagemags = [Averagemags,AvgMagnetization]; 
 

end

plot(1:0.5:4,Averagemags)
title({['Grid Size = ', num2str(N)  ]}, 'FontSize', 20); 
