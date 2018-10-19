% October 2017 -- Markov chain algorithm
% IsingMarkovSee.m
clear all; close all;

L = int32(25);
N =  int32(L  * L);
nbr = [];
for i = 1:N
    j = i-1;
    j = int32(j);
    nbr = [nbr;idivide(j,L,'floor')*L + mod(i,L) + 1, mod(j+L,N) + 1,...
                    idivide(j,L,'floor')*L + mod(j-1,L) + 1, mod(j-L,N) + 1];
end
%
tic;
nsteps = 10^6; 
M = 10;
% You can change the number of frames displayed by changing M.
% M = nsteps will display every frame.
% The code runs much faster by displaying fewer frames.
T = 2.25;
beta = 1.0 / T; 
replacement = true;
S = randsample([-1, +1], N, replacement);
Ss = [S];   
for i = 1:nsteps
    k = randi(N,1,1);
    delta_E = 2.0 * S(k) * sum(S(nbr(k,:)));
    if rand < exp(-beta * delta_E)
        S(k) = -S(k);s
    end 
    if mod(i, nsteps/M) == 0 
    Ss = [Ss;S];
    end
end
toc

% Visualtization
for k = 1:size(Ss,1)
    Si = Ss(k,:);
    magnetization = sum(Si);
    for i = 1:L
        mat(i,:) = Si((i-1)*L+1:i*L);
    end
    colormap([0 0 0; 1 1 1]);
    image(mat.*255);
title({['Temperature = ', num2str(T)  ];['nstep = ', num2str(k)];...
                ['Magnetization = ', num2str(magnetization)]}, 'FontSize', 20); 
set(gca, 'FontSize', 20);
                         pause(1);
% You can change the duration of the pause between graphics by changing the
% number of second in pause(seconds).
end
  

