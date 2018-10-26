% October 2017 -- Markov chain algorithm
% IsingMarkovSee2.m
clear all; close all;

L = int32(50);
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
nsteps = 10^5; 
M = 100;
% You can change the number of frames displayed by changing M.
% M = nsteps will display every frame.
% The code runs much faster by displaying fewer frames.
Averagemags=[];
for T = 1:0.5:4
beta = 1.0 / T; 
replacement = true;
S = randsample([-1, +1], N, replacement);
S = ones(1,N);
S(1,1) = -1;
Ss = [S];   
mags = [];                              %%%
for i = 1:nsteps
    k = randi(N,1,1);
    delta_E = 2.0 * S(k) * sum(S(nbr(k,:)));
    if rand < exp(-beta * delta_E)
        S(k) = -S(k);
    end
    magnetization = sum(S);             %%%
    mags = [mags; magnetization];       %%%
    if mod(i, nsteps/M) == 0
    Ss = [Ss;S];
    end
end
toc
AvgMagnetization = sum(mags)/nsteps  ;   %%%
 Averagemags = [Averagemags,AvgMagnetization]; 
 end
plot(1:0.5:4,Averagemags)
title({['Grid Size = ', num2str(N)  ];}, 'FontSize', 20); 
          
% % Visualtization
% figstep = 1;
% for k = 1:size(Ss,1)
%     Si = Ss(k,:);
%     magnetizationState = sum(Si);
%     for i = 1:L
%         mat(i,:) = Si((i-1)*L+1:i*L);
%     end
%     colormap([0 0 0; 1 1 1]);
%     image(mat.*255);
%     if k~=1;figstep = (k-1)*nsteps/M;end;
% title({['Temperature = ', num2str(T)  ];['nstep = ', num2str(figstep)];...
%                 ['Magnetization = ', num2str(magnetizationState)]}, 'FontSize', 20); 
% set(gca, 'FontSize', 20);
%                          pause(0.1);
% % You can change the duration of the pause between graphics by changing the
% % number of seconds in pause(seconds).
% end
%   

