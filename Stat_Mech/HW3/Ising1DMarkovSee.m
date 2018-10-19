% October 2017 -- Markov chain algorithm
% Ising1DMarkovSee.m
clear all; close all;

N =  int32(100);
nbr = [N, 2];
for i = 2:N-1
    nbr = [nbr;i-1, i+1];
end
nbr = [nbr; N-1,1];
%
nsteps = 10^6;
M = 10;
T = 1.0;
beta = 1.0 / T;
replacement = true;
S = randsample([-1, +1], N, replacement);
Ss = [S];
for i = 1:nsteps
    k = randi(N,1,1);
    delta_E = 2.0 * S(k) * sum(S(nbr(k,:)));
    if rand < exp(-beta * delta_E)
        S(k) = -S(k);
    end
    if mod(i, nsteps/M) == 0 
    Ss = [Ss;S];
    end
end

colormap([0 0 0; 1 1 1]);
for k = 1:size(Ss,1)
    Si = Ss(k,:);
    magnetization = sum(Si);
image(Si.*255);
title({['Temperature = ', num2str(T)  ];['nstep = ', num2str(k)];...
                ['Magnetization = ', num2str(magnetization)]}, 'FontSize', 20); 
set(gca, 'FontSize', 20);
                pause(1);
end



